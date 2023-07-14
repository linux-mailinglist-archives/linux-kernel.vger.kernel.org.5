Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC1A6753ED5
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 17:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236260AbjGNP1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 11:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235457AbjGNP12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 11:27:28 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B7C22D68;
        Fri, 14 Jul 2023 08:27:19 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.49.15]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N79ly-1psslm0QVI-017Yy8; Fri, 14 Jul 2023 17:26:46 +0200
Received: by leknes.fjasle.eu (Postfix, from userid 1000)
        id 13BD13E8B8; Fri, 14 Jul 2023 17:26:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1689348404; bh=w4fRc/ie8uyI+ju21eroczebVyv8KrZnltwBlvcBpv4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1C+qX0vJ10rrMR1HGgPXWjwv2z1KxZt5xutHcYJSsXmjCh0ncrUpREzoisIjP1L81
         dOA62e++7/8yPos9yD1RzKk3KSXqlR3bgomvrTq/5pFAiA7kzwBfPDLgmADvgA7X7/
         EQ3WsG6+hibtB0kJ9CerUpYPegrq7fEiJKSExvDk=
Date:   Fri, 14 Jul 2023 17:26:43 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     linux-modules@vger.kernel.org, Takashi Iwai <tiwai@suse.com>,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Jiri Slaby <jslaby@suse.com>, Jan Engelhardt <jengelh@inai.de>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH kmod v2 3/4] kmod: Add config command to show compile
 time configuration as JSON
Message-ID: <ZLFpM+H2bfkJx65S@fjasle.eu>
References: <20230711153126.28876-1-msuchanek@suse.de>
 <20230712140103.5468-3-msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fJQQMulXf8UyxTpY"
Content-Disposition: inline
In-Reply-To: <20230712140103.5468-3-msuchanek@suse.de>
X-Provags-ID: V03:K1:PGXsAgTlLd3IPcf8lVHUJ+OD1BksbcdYQmYDdQSSKktdepbPWZ4
 rjvBCtMpqp1ip0eP9UERtt8mAp6mv0C6aAeOhqCT2J0EB/JNzbIZHhBvjmnTs5XMPmPzdiu
 fmjnjMEe1Iv1Cb6KLoHq0dch7I4FAgGfJn1rSQnE7XMlYTGtft1jqIlA7zwvc6q+VcINyz3
 1Kei9tCds5L16Yt6leq2w==
UI-OutboundReport: notjunk:1;M01:P0:rxmSj38tAwQ=;kTw1vgYOjLXLYwfJYOfRJMk9dUy
 cfHsqZQM5+em12BcYG6GLMa+Ut81myYD26f63c34qREjDh9GkePrGSed/8xGjN0q+f49LJafd
 jkMlJHBhIC6OIOL/AwSU70bBsTPhsOl60C7R0bVJ50vJchGeO/SJKsyWdlmkI++M9t4oBKtsH
 wmir+Q620M1LQZihfXE3+95pIhrXxROM5kst8fNKvMpjbeX4XYH3MKKQhfQqwSYGfx/qaGCUV
 lRvsIe3mTeHrm4Xdu7loAv2su0DWE7zilYnYGmuVeCJ6cj9kDdZ1UI/Mkp5p/KqA8OludvziU
 nWJ28rVQ17lEtRuxv5VHXUTL3FChS3wi7IVh4K50BGVC8g7R3RQ3gXiqXhv011ddDjEZYkcZJ
 6LitFw+0XS8gnecMWBDQHooGUEacEenX84K6WG0YSpKMDaQFASJbIPQBHFpz5P3JBeKpgqJSS
 dPXwthEljMtYC8SEjQuKTGDBRwJBI6HoAQTGC+C2jG+jJ3InQGOp8srm1spc+h5eR9Y+24e2R
 VKQlXf+29S1mLZpp2qST28QXSF/5ZWdzBxz6L2oGz6wlNpI4VAUlTLNbT9mMN3IA1UVfOg8kj
 Et09iduhcWUcXkSnHQKEf3t1Hn8VTh4wyeeEcQOHoyf2NIbIl9oS0dqfkMIA1vtiUttAmty5K
 JL8i0QElmfUrTpyXZwplVt1NTQpemyyowL/yL9X1rw==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--fJQQMulXf8UyxTpY
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 12, 2023 at 04:00:47PM +0200 Michal Suchanek wrote:
> Show prefix (where configuration files are searched/to be installed),
> module compressions, and module signatures supported.
>=20
> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
> v2: mention module signature in commit message
> ---
>  man/kmod.xml |  6 ++++++
>  tools/kmod.c | 39 +++++++++++++++++++++++++++++++++++++++
>  2 files changed, 45 insertions(+)
>=20
> diff --git a/man/kmod.xml b/man/kmod.xml
> index 0706ad58c2cc..f992a500f836 100644
> --- a/man/kmod.xml
> +++ b/man/kmod.xml
> @@ -71,6 +71,12 @@
>            <para>Show the help message.</para>
>          </listitem>
>        </varlistentry>
> +      <varlistentry>
> +        <term><command>config</command></term>
> +        <listitem>
> +          <para>Show compile time options in JSON.</para>
> +        </listitem>
> +      </varlistentry>
>        <varlistentry>
>          <term><command>list</command></term>
>          <listitem>
> diff --git a/tools/kmod.c b/tools/kmod.c
> index 55689c075ab1..5a13716955c1 100644
> --- a/tools/kmod.c
> +++ b/tools/kmod.c
> @@ -37,9 +37,11 @@ static const struct option options[] =3D {
>  };
> =20
>  static const struct kmod_cmd kmod_cmd_help;
> +static const struct kmod_cmd kmod_cmd_config;
> =20
>  static const struct kmod_cmd *kmod_cmds[] =3D {
>  	&kmod_cmd_help,
> +	&kmod_cmd_config,
>  	&kmod_cmd_list,
>  	&kmod_cmd_static_nodes,
> =20
> @@ -95,6 +97,43 @@ static const struct kmod_cmd kmod_cmd_help =3D {
>  	.help =3D "Show help message",
>  };
> =20
> +static const char *compressions[] =3D {
> +#ifdef ENABLE_ZSTD
> +			"zstd",
> +#endif
> +#ifdef ENABLE_XZ
> +			"xz",
> +#endif
> +#ifdef ENABLE_ZLIB
> +			"gz",
> +#endif
> +			NULL
> +};
> +
> +static int kmod_config(int argc, char *argv[])
> +{
> +	unsigned i;
> +	printf("{\"prefix\":\"" PREFIX "\""
> +			",\"module_signature\":["
> +#ifdef ENABLE_OPENSSL
> +			"\"PKCS#7\","
> +#endif
> +			"\"legacy\"]"
> +			",\"module_compression\":[");
> +	for(i =3D 0; compressions[i]; i++) {
> +		printf("%s\"%s\"", i ? "," : "", compressions[i]);
> +	}
> +	printf("]}\n");
> +
> +	return EXIT_SUCCESS;
> +}
> +
> +static const struct kmod_cmd kmod_cmd_config =3D {
> +	.name =3D "config",
> +	.cmd =3D kmod_config,
> +	.help =3D "Show compile time options in JSON",
> +};
> +
>  static int handle_kmod_commands(int argc, char *argv[])
>  {
>  	const char *cmd;
> --=20
> 2.41.0

If kmod could show selected configs without some (JSON) syntax
around, it could simplify its proposed use in kbuild. E.g.:

    kmod config prefix 2>/dev/null

instead of

    kmod config &>/dev/null && kmod config | jq -r .prefix
=2E

--=20
epost|xmpp: nicolas@fjasle.eu          irc://oftc.net/nsc
=E2=86=B3 gpg: 18ed 52db e34f 860e e9fb  c82b 7d97 0932 55a0 ce7f
     -- frykten for herren er opphav til kunnskap --

--fJQQMulXf8UyxTpY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmSxaTMACgkQB1IKcBYm
EmlX1g/9Fjx7AiAkqXg4PZl98829BBzPlnBaGjiGGM6tKnKhws312/R4+BdmXTis
Bp2JFS2Gv2WxbsYnQq389e+xqXNKrvVAGw7E/T3XFyOb58UxrJMr92xNROGS4dq1
+Y/AySkiSzkqyZB/dffLYQ1yz102OC+okrN6XpQ3AWOr9f/sfji+Ldd32L0jhHRW
k/Q0yIMOx+LqhpnsTf1TuYKrIrs6iP7+NEPKlYXQGvi5lObH8XGWWMYKAV8skgE/
A2au3hIxMUwuwuuT+vIMixbPGL95Sws7ZcYWz6CI8p8ATpg76/ODinOSo4+9GBfu
pb3ni8Bk382vcQnxAnpSqkFdiG9D7WLId2D5Ri61B9ZzVco30Qqdc82Jf3z4U7PU
3z8gmYf8EcqKBA0BjTTQ+OzM2rRGPgAoWuCcKy5VbFCFznUQ5Yn6pq7K2hKgGW0h
7l6AspmNRKuxvk3uneuSmoUeXo/Wnl1nyL0ZZR86n5CU5/PkUQZfFtXLwnTvsLR3
wqmCCD4y7Odpkwz4aSLiSRMEdtoQ244qhIUf6TjsxChbgpaAG5DEDCRe7UNHFYJq
aKQbf994BZnsNr/qlH9WWGAeKOVBTTZxuNvrZDBTkXUzyauwM+u4dLxziQfag8Yg
FkVefUWTabrmo9a+WiDyiN+5Ta9N1CmDk0M8o3MXnI3W0EqiBsg=
=WJb2
-----END PGP SIGNATURE-----

--fJQQMulXf8UyxTpY--
