PGDMP     4                    {           RunescapeGE    15.3    15.3                0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                      false                       0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                      false                       0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                      false                       1262    24960    RunescapeGE    DATABASE     �   CREATE DATABASE "RunescapeGE" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'English_Canada.1252';
    DROP DATABASE "RunescapeGE";
                postgres    false            �            1259    24961    items    TABLE     �   CREATE TABLE public.items (
    item_id integer NOT NULL,
    item_name character varying(128) NOT NULL,
    item_description character varying(240),
    item_image character varying(360),
    item_price character varying(12) NOT NULL
);
    DROP TABLE public.items;
       public         heap    postgres    false            �            1259    25011    purchase_id_seq    SEQUENCE     x   CREATE SEQUENCE public.purchase_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 &   DROP SEQUENCE public.purchase_id_seq;
       public          postgres    false            �            1259    24994 	   purchases    TABLE     �   CREATE TABLE public.purchases (
    purchase_id integer NOT NULL,
    item_id integer,
    buy_price integer,
    amt_bought integer,
    total_cost integer,
    buy_time date,
    sale_id integer
);
    DROP TABLE public.purchases;
       public         heap    postgres    false            �            1259    24993    purchases_purchase_id_seq    SEQUENCE     �   CREATE SEQUENCE public.purchases_purchase_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 0   DROP SEQUENCE public.purchases_purchase_id_seq;
       public          postgres    false    217                       0    0    purchases_purchase_id_seq    SEQUENCE OWNED BY     W   ALTER SEQUENCE public.purchases_purchase_id_seq OWNED BY public.purchases.purchase_id;
          public          postgres    false    216            �            1259    25000    purchases_sale_id_seq    SEQUENCE     �   CREATE SEQUENCE public.purchases_sale_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 ,   DROP SEQUENCE public.purchases_sale_id_seq;
       public          postgres    false    217                       0    0    purchases_sale_id_seq    SEQUENCE OWNED BY     O   ALTER SEQUENCE public.purchases_sale_id_seq OWNED BY public.purchases.sale_id;
          public          postgres    false    218            �            1259    24968    sales    TABLE     �   CREATE TABLE public.sales (
    sale_id integer NOT NULL,
    item_id integer NOT NULL,
    sell_price integer,
    sell_time date,
    amt_sold integer,
    total_price integer NOT NULL
);
    DROP TABLE public.sales;
       public         heap    postgres    false            �            1259    25012    sales_sale_id_seq    SEQUENCE     |   CREATE SEQUENCE public.sales_sale_id_seq
    START WITH 226
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 (   DROP SEQUENCE public.sales_sale_id_seq;
       public          postgres    false            p           2604    24997    purchases purchase_id    DEFAULT     ~   ALTER TABLE ONLY public.purchases ALTER COLUMN purchase_id SET DEFAULT nextval('public.purchases_purchase_id_seq'::regclass);
 D   ALTER TABLE public.purchases ALTER COLUMN purchase_id DROP DEFAULT;
       public          postgres    false    216    217    217            q           2604    25001    purchases sale_id    DEFAULT     v   ALTER TABLE ONLY public.purchases ALTER COLUMN sale_id SET DEFAULT nextval('public.purchases_sale_id_seq'::regclass);
 @   ALTER TABLE public.purchases ALTER COLUMN sale_id DROP DEFAULT;
       public          postgres    false    218    217                      0    24961    items 
   TABLE DATA           ]   COPY public.items (item_id, item_name, item_description, item_image, item_price) FROM stdin;
    public          postgres    false    214   S       
          0    24994 	   purchases 
   TABLE DATA           o   COPY public.purchases (purchase_id, item_id, buy_price, amt_bought, total_cost, buy_time, sale_id) FROM stdin;
    public          postgres    false    217                    0    24968    sales 
   TABLE DATA           _   COPY public.sales (sale_id, item_id, sell_price, sell_time, amt_sold, total_price) FROM stdin;
    public          postgres    false    215   �-                  0    0    purchase_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.purchase_id_seq', 252, true);
          public          postgres    false    219                       0    0    purchases_purchase_id_seq    SEQUENCE SET     G   SELECT pg_catalog.setval('public.purchases_purchase_id_seq', 9, true);
          public          postgres    false    216                       0    0    purchases_sale_id_seq    SEQUENCE SET     E   SELECT pg_catalog.setval('public.purchases_sale_id_seq', 234, true);
          public          postgres    false    218                       0    0    sales_sale_id_seq    SEQUENCE SET     A   SELECT pg_catalog.setval('public.sales_sale_id_seq', 252, true);
          public          postgres    false    220            s           2606    24967    items items_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.items
    ADD CONSTRAINT items_pkey PRIMARY KEY (item_id);
 :   ALTER TABLE ONLY public.items DROP CONSTRAINT items_pkey;
       public            postgres    false    214            w           2606    24999    purchases purchases_pkey 
   CONSTRAINT     _   ALTER TABLE ONLY public.purchases
    ADD CONSTRAINT purchases_pkey PRIMARY KEY (purchase_id);
 B   ALTER TABLE ONLY public.purchases DROP CONSTRAINT purchases_pkey;
       public            postgres    false    217            u           2606    24972    sales sales_pkey 
   CONSTRAINT     S   ALTER TABLE ONLY public.sales
    ADD CONSTRAINT sales_pkey PRIMARY KEY (sale_id);
 :   ALTER TABLE ONLY public.sales DROP CONSTRAINT sales_pkey;
       public            postgres    false    215            x           2606    24973    sales itemID    FK CONSTRAINT     r   ALTER TABLE ONLY public.sales
    ADD CONSTRAINT "itemID" FOREIGN KEY (item_id) REFERENCES public.items(item_id);
 8   ALTER TABLE ONLY public.sales DROP CONSTRAINT "itemID";
       public          postgres    false    3187    214    215               �  x���Ok�0�ϣO1����r!��B	l/Yz,�=k++YF���W�=�B[�EB���_H������j1��i�d��T�.�	�!���n�[%��wr���fg�T ӷG�w�M*�:�Y�m�z���r2�ӽ���*�������x
<J�n�-QM]�h�r8�E߂~����:���SG�'�3i�߉/ES5\dNZ/2�
x�o�����	����%��g5F�%:�k(�������c�4[П��n��+mOY�YE/x��=�.�'�ږ����nԄ��;�|�n��Tׁ�z���.(;mXϸ�^V����d���͎<MA���pP�pY�����%wF�׍�����.J�,�"O�e
�&���{;xX��W��5qa�U
�޻��,��9�yʚ��5��Jۣk�R�^��O�؈      
   �  x���Y�I�wѼؗ����1f`ue�~����j������g~Z͗�>��:���\۟��������Ƨ��m��o���Z�}}6�3��3�\�����Hud6�c��k�Ϛ{`��۬�]����}���צ]�|�1|�5Y��X�%��V��F���?�׃����qf��1l��pͷ���_܅�{��9����si��s2N�>�����>��˓��}błX���{���7�Dśo�8�^c促�R�nT}[�g�Z�j?F�O��&�b�6�G:��˄Ϧ&���a7����*锺���·���?�)x+y�ϧ�EJ���>�Y�K$�ԉI&�j�}�2�{�����Ïa���߳��Yi�F�u��?��r~M���t4�e<V����ݯM��Tr��,β��7�x�T�nݼf�хN&~���JIE����c�
�^ω�|M%\�"w9���Q��&��e�m^�ڣ����s�T"3X7�c-���_O<R	?kY[.�33Q{�5SYqjv�gW[�>A��e%���}����@ɝe'}E�~]ٲ�g���GSP9���F!�{�f����_SS�����CO��T����Kpt�Wɀ�L̔�(�B7��!g&0��q���u�S��j~�mM��f�1�����~�$���([�||c��$�؏� ���q(@��f���%�TE�SX��˺I^.?j���~�hR�g`��8jƹN��5��N��|G�<;�ur�.��zBl?e�υ!4�a�-l�T�g���K8�<X���P6���A$� �����8l�v]�{�7L�(v�v&�^�}�6R���[��g���9=N �E�*Įoٹ�"��m�h#[��ϵ=��U��NM�^ܵ����gG������pa�r¾.�������Zި��Z���[�e�YYD 2�}z=n g髽���&�t�J.Oa ����_�>Pl��*�bD�'= DY�"Y����S�����6iiF�	y���s3�k�*�Sw�o��ُ���\B);��(y�i�q�y_Z����z��9���Z�m��O��m_�t'��ESD��e�+U�g�D����*A��JGM��C�Ʋs��:�h	Tè/����egR��3���l�H}ꨎM��w���˹�w7+'�]~���	NcŹđ����q��Xi찲t	���!W/�l'��ώ�4Y������y�̱~�Xh�����n�͜fx�١@.6�V��40+i֯�m^B����&d�����-�$�J~"NB͖f`�ǛU���S��c�4�?��AqA ���=��i~ N�@|���E�ʜi~C�� b9�8�N����ߘ�n����\�8w��3}��p=>�'�@�la���{�ɸrZ�c�m�*"ʹZ�e�V�����PX����U���>�
�s�����kWK+�_�ﳥ^�r�W�Z=��}������5�R��^�t��^|+h䒕���T'-�� �����0$�Ti����u���KM��,ؽ>��v����(�B:R!2���9�-��A:S���_���%����'�$�W&ؠ�������l�u5�";L[9�z����%vO[Q9,�e^��L�.��H{�ʱ��/h��qa�v���L��M�{U$����pgSq(��s�0i���>qt�#M���V��I'<>��=60��slr��tB��i�>�a�޹�uY���Ӯҏ|�����e���>I����W�������{�")���������Y��o-�?Oj�g$)�竉3���j��f���I;� �K]Qa��N$y3O#Wh�8�]���gk�ɨ@�<���G�N� �Cr�KV`0M��/Y-���D+Z�G��V:�?����Ȉ&�W2���*+8�V�����������U^^��᱔X �50���$	]��,]��� ���D[�)'k��awD<�WH�ȼh?~b��#4<����<�LV�e�/!�Q S���:�"JQk8�x�A���]�9P��{zˆٚH��x֣)Z��';��iy����<��_�`A�3�"4)�R[E�Z@冶�՚��Qe�r-3+����h�,�ע�k�~C�l���_.S���n@� c��zZQ��_Z��1�H�ke� `K��`n��"������$W����& p�����}ՙA���B����/4c��7��@��N��KtiF j@4$�{���-[j����^�ҲGB���#ID�kf�g��2E�U5��l��վ�B�?��Zr�`�6��n(��D�D�N��������kK�WZ=�x��K}�&zr�b�ԁ����3���r�^�Ѥ����Lu���٬0߳i�V���ȋ�Iz[l����?�:���-��J�k�RF���=:kA�B�~��y@�r.WYM(Z�9'�0l����6*B���ݶ)ih5�Q_��֙����6"E�}��U����8ˁ`�~Am`V�od,Y�Or�!��L��(�1c�8(&��D��hƶ�Q����vc`���`�zF=`][z� N~+���k0z��7�|$���kĄ	fQ���
��\��V�H���ȑs��p�Q:c+�pγ��ж%f��f������� o;�2�aZ�~^@������AC^#@�����.�8C$�6���y�
����}��aGy�#,���l�>E�\���,�[�O��U	t�y�`/@�_+�|M~~����`���#�:f�yח��$��ַ�gq��V	��9�<#��B-��i_g�oa>��x9'f��wCD�:��:�:	��`WGq6��gǺr��}��e����8���7�A��9���ޔ4pչ�]x:?���!{v�p���JF�����Q��:�=�QxG�".����'3��ruk��Ԇ��9�%�[ң���|�v�h����W���4#���\� #�����>��������зeE��[��`	�_�T��+�ob��&.�/W p����Y��q���
H�O�!��q{0Q���O�:�_��v�i�W��h}*SE�$1�^p�["��_�F |���)'@3�Qƣ�D=���}�f6}7�/g�.��-��6��Kշ��T�&�.`K��Q�^����\��ǔ�8�j�x�jxu��%�4׸��z������ߧUЛ������6r���2�F/�@�b����T
z=��P f;ǫ�͋V+�F��,�vp��>r#2�W�ƽ�glZ��s��l��e��6J~Ts��H�Fr��C�;ؓQ����=(�r����5�½_l.�;���ޘ'����5O_tS�pC=d������jl�p" R�����œ[�Q��I{0�VK�d����J��X�>�ZM���C��HzO�o�x|�e`�V<����>w�XїBu�4I���a�����T�1�n�'��gw���]��g�,�d�ϙ��%�g�Q�m��a?��7�~h_m>&�V 8tedl9�s#O�!=����L0[�&�u�z����5��+���'�sY�p��z��'v������u5UϳZ\� 8⑴8�Z�'$g\�'`�L��;�:L]�:�'%b`��� <�_�GƉ"�9�~��)*B��|Z:HJ�Ŭ��M��s��#� �h��j�{O$qu����T>5ҹO��,A\KD@�rb���I�F����ͬ�#@��:_aB��7�(8.�p�kf��#�_����S�uuE'�8�F�G�s�i�s����tk�}RY��|k��k�^�*����!���>֭��j�N{z)חB��������v����~� R��mT�@��h}���w~��/��2�__hi>�^��-nz�ϷT�#���oƱ|t�1�q�6��qC���L7���o�����37W�Ĳ��@߆��%�����L��%&���H�x��M���w��,,����������K�           x�m�k�d���2c�^��u�)�Q�E����vS�T�nO{����>���g���e��s���������g��6��w|��~��zz�c����`�?m�şmD�V�\�����5�z8?����a��u<��o}־�*Ks}\X,<��1�,[���8]_� _sn�I�?�^�6�3��{i-o{"�9{/��[�&�ƞ�@��@|v��Ky��C�ߨ�Hb���H,�s�=�2��������c�ߣY���ߕ����c�0ߥ����49A�j�#�ڱ�����~0[u�d@�B��9��VKOh�UTY�ңr��$�c�e�T��=kq]�,]��7�pW�&��K��Y%���{X�	�^7�TU�ެy�oA�I"'�����t>{�ާf9�X��)��GϢ$�-E��n�Ŋ��	|�yWB�򟘶U�}�ɚ�	٠V�_�j��$���L6��(�>�B/��kA�%oB!zwǤˋ��A���Gw#�԰�X�h���EA`��f��t�_��Qt�g�}b��K���HWJpc\3���f�͇�
<�>3E��ͨPƋ팫?�e:^�����Hp�<�Й�T�>c�]����WQe��k �a�2�vu&��0��j+�3��'�LJ*��(���V�~I~����O�h1a�gm�ʜӼ=kS�Ե�t�~�$�P1�mЩ��9�}�ϩ�qD�1��lg�&�]�����9�Ŷ�[WAr~�>��b�ucw��/׌b��Yf.xck-O��B�*;����4�m����f�[kP��58�4�9d����\�F���_�e���������ji2ߣ�A�nv��bBM�B���,�?�]�Ȱ�9
�!�8АSZ�v�$a�d�b��P|���X�Pv���
�u?���텞�1�$Ԭg��^�)��w��N�Ӗn5V<�u�Ss�р�UO|OYͼ5$!^���Y/�����Ee��NG�x^bD�Ԯ��N=O�珏,K��1T��x��o��3�
��(��ٛ%�S��C-��l��5Vg/�G\5#�e{H[x+�b<�ϋZ����c����د��ֽj"�%c}�͒P��LzrQ"1��L=�9%�a�@Io�,�0f���P�)��hpap�Dס��F�RK���Vz�Ѓ����X�q,Tx����^4d9�b� ��7��z��d���T&m9PG�{ ,XD���݆"��� ��iW�)�!a]��ފ�*%�%-�l�B#�*~�@�0l&�u�D��6]�H5!8&1����F"�ݡ����+�TߔF������8p0&�L�:
�E��*��*�H<Iى�E�R�.�3!� ��?�B�{�lHҽ��s��R<
�����N<��L�N��yT��x���E2���m`�V�%��d
:�MR?����(r�N�.΋�8d�q�ϗ�L0祇�� �ktD|�����$�I�)�|�&�ztƂ�Ee�����ژ8H&��.������ne-��򠋘`h�W)N8����ɾ��� g���2��*h��V%ұ��D[�=�2���Z��)�3
.��A���0�rr���jc�DGi ����!��#zI�c|d
��%�Y�t��3�k�y6���n䧍�d|
LBګIǴ�"�ш����y��٨�h�M��Bu�E�]�M��2>	Ν�#��	Q�	89ø�֢�!S	�s�Q�S��dY(��5�hZ��
�7]�k��]�h��jH���HX/5+ℇ`O&��1��eM�.N�:��������H �u_[&3Ϲ:#+Ip��bB�;cd��A��j�=v�{(�*��S���g�h�������CM]�O��H�&���!*�[!��p���e�e���7$Sמ�f��P��i�d��]B5���t��'���2��M'����c{,>����U�̴ńV�6�a?7�)N���%�q�����d�`kofO��j����52����=_�<����2��h�D�c!�m�4B{f��>�'Ƈ���<����b|���-�#�#>��y(QP�{�$7�x�&-��n�hMsτ��w=3�Kg{k
R8͋9�ÊT,�CG��qK6y�cK��b���|B�Y�t��o���h����G�.�K�'���Ā-R����j*S��x|ab2�O��Q$����H?��U�CkE����� �UC����dɤ]�9�GBf��L�h�8>r[�`�^�jN{�1g�h��U�rO��u�R������E�U�h��H4͹�I"�/&�����C<������m�E���������ĺ�g��}�)6[ZW�Քr/z�����}�O��@<!��j�nO�[rL�~"}7��G9g���ɾ&RU�K̪r�b6�~�S�j�V���~[Ў����Yd��lK@�[%	�=�5�Am+$���l܈����� Td<&c݀0��wߠ�^�WsG5㎦�"�0�6Ry��GtĢ��&�����Z3�>��f�T��[��H��Eg�B��M�9��F̃�l�1��&�C�W�1�Ҿ�����7t%�\n.`TR���#�������ƍeBK&���6V5�YQ�Zu��7>�T�D�Wd�Hv���?͠*�Mi�~bɵ���9�{��� �irH�V&Iu��w��mDW
1$��r�x9ǹIM�Zz^�LOz<���Mڒ�.��g��'���u*��n�[/`�����4�&I;���O������%�]�.�9�r+A�d�	�.iDȳꩳP�2�֘�{�j��CJcB���n������SESV�m׍�ؕ�VQ
]C��/��D%b���-�=�*�е��F����f1��B�>(��)�*��c2��,��⟇�X:J��[�n��_����0zMo��{���%;*���Ibvm�Y�KtDf�aE��Aw�+U?��R�"A�C��<L�9j�!�H�j>-�nGׇL���I�����Hv�k����Ϥ$�3E?u�>���P��&��+�-@���0���%O년��a���͙���)��+P�=R��Ή��F=�N.��@��q,�ꕿX����u�Y#R��%'	��Х*����_J�xɐ�_\EN���4|W�U��)_V@M��:�&��v�Zx��,fz��C�l�M��s���H/��Y�7�y����g ftՍ�)��O)�*�&�     