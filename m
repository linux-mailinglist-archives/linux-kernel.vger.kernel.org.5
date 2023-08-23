Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5320278611C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 22:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235885AbjHWT7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 15:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238443AbjHWT7Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 15:59:25 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5641F10C2;
        Wed, 23 Aug 2023 12:59:18 -0700 (PDT)
Received: from leknes.fjasle.eu ([46.142.48.46]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Ma1HG-1qBikl3Sfk-00Vwhe; Wed, 23 Aug 2023 21:53:35 +0200
Received: from localhost.fjasle.eu (kirkenes.fjasle.eu [10.10.0.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by leknes.fjasle.eu (Postfix) with ESMTPS id 536953F8C0;
        Wed, 23 Aug 2023 21:53:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fjasle.eu; s=mail;
        t=1692820410; bh=GKOk5MTY/v4XTWXhlEfjiFJxiiEgn5QhRpYC38mJgtI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JC8lNW8idZX8RJR8ds+8m4QB/2Z2fHdxLzUk5rTVpk2S7BySMjPjaUTP+fgggipGZ
         c853knJzqhR30b2YHe1b7Ry1XgT1FrXI0wes8IPk1dhr2bUIXbhB5UBkZvTJBgOwlr
         +BjIqXXL6bIZbEC8Q0MMwvlLVZMTRmapkGJfbk0o=
Received: by localhost.fjasle.eu (Postfix, from userid 1000)
        id A1D435F39; Wed, 23 Aug 2023 21:52:56 +0200 (CEST)
Date:   Wed, 23 Aug 2023 21:52:56 +0200
From:   Nicolas Schier <nicolas@fjasle.eu>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: Re: [PATCH 1/8] kbuild: do not run depmod for 'make modules_sign'
Message-ID: <ZOZjmLPxwWik/YOz@bergen.fjasle.eu>
References: <20230823115048.823011-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+/FtnWWBCMuQiUfl"
Content-Disposition: inline
In-Reply-To: <20230823115048.823011-1-masahiroy@kernel.org>
X-Operating-System: Debian GNU/Linux trixie/sid
Jabber-ID: nicolas@jabber.no
X-Provags-ID: V03:K1:M1PkP04ts/rPPHOsL3u6h1ACqUU563GekuG/27AsnPA+Q5oSbXp
 /3liXI9u3+25q364Wv/5e6wiyuSVqmvI+4lgNSejhEPeCEWojXVfpbA63+7Zq1NMOgrXxRL
 QS7Jr0/gQOLeD9l24NfQ4FinIPlFIIPAOxdM2LM62Vsu5wJ1+lawFbJVfh0w/vsA7saAXw8
 xHO6Zubdt4xhuccV7kyRw==
UI-OutboundReport: notjunk:1;M01:P0:E7zuzkOgrdI=;RbGDFRy9GbX6WfvWJ49C6LNLhkg
 5+CGWrZPZx/mNRrhjLrMR5czS4Z+2oZpd9CFDDkPID5JwdrD00dQlXz6TVcrtXnjEusOQ5nDG
 5FH/3v78oRqkJ/qcvhOscWmnOgusGevMhcwthaVv88cfwyCG04beLdMsySwKegfR9/5DWWwQu
 pn08+hwgy2Vf35FvRbk4qA31jGfG3wwk1yUFQolfjBepMrGohxvy2q/TO2py1Nj6LO9vxKclf
 SvE+ODTdFIfG5fRyKaIWhbgDdqAEpuvQA1nUuTi34lF66n23u0dRwuXIe8FuhEjMx5OXhsGrA
 v+4JzpUhdweKztiUJal5uTT2TB0Xs8V/MUf29fScPXjxRX+BFxhK2RoTQIYVowVE3nkjt5Bk9
 GHI9UcU6uVS29H81+Ofnmn+NTrTwJdQlblStXPwDOoH0+IyQegUD/7ko5fstsjEG7uKtvNT4m
 +kUXT49ydQISG+jowvBNhv+0oroxdhClyLH5z4IeWGe9faHmBj2gdbfWKq1fTVatgRyT0GErQ
 NC3lC2/iiYNshRzfZMKYtXurW2+3iV3unLM2huFMvk3XhR/0tRW2ah15SEWVDSGDo8SD4PhZ9
 RPws8UwJrZ3SckaTmNxsonW+V8sDc6NjVapZJMYrNd40T+BJal5bzS2ERqvaF/1/hmVFQQTJy
 FmPRnXIA0RowHaGbPAlXftUwvb4FNW9BMnHe9ZeKxNp3i2md4O+Z7WsoCmim3NLKZ99SXP03m
 1N4tpVxoGy/I4aojNO917giZB5jmn+x8xp77CNo+Q4k04ayU6OZPO4kEBFzMy8EdR+UIKrOje
 YtHrXwMnzTN65UXyFq5vRgH4FpqkJy7qldiF2kxb4OK3sz1OjvQF+k8sVLfaZW1YKhl0S/o45
 pWlzqrZD2cnIxfQ==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+/FtnWWBCMuQiUfl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed 23 Aug 2023 20:50:41 GMT, Masahiro Yamada wrote:
> Commit 961ab4a3cd66 ("kbuild: merge scripts/Makefile.modsign to
> scripts/Makefile.modinst") started to run depmod at the end of
> 'make modules_sign'.
>=20
> Move the depmod rule to scripts/Makefile.modinst and run it only when
> $(modules_sign_only) is empty.

Moving the depmod rule is in patch 3/8, first half of the sentence=20
seems to be left over?

Reviewed-by: Nicolas Schier <nicolas@fjasle.eu>

>=20
> Fixes: 961ab4a3cd66 ("kbuild: merge scripts/Makefile.modsign to scripts/M=
akefile.modinst")
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
>=20
>  Makefile | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/Makefile b/Makefile
> index e0d52539a0f1..7d54a0700c6e 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1877,7 +1877,9 @@ quiet_cmd_depmod =3D DEPMOD  $(MODLIB)
> =20
>  modules_install:
>  	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.modinst
> +ifndef modules_sign_only
>  	$(call cmd,depmod)
> +endif
> =20
>  else # CONFIG_MODULES
> =20
> --=20
> 2.39.2

--+/FtnWWBCMuQiUfl
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCAAdFiEEh0E3p4c3JKeBvsLGB1IKcBYmEmkFAmTmY5IACgkQB1IKcBYm
Emm/3RAA5KswfhNDW9x3xANz1SbvNruE7AMIyEdTVtNjbvraf6o64m+I2oMtr+c8
ismL0KlcV0AtE9iPusb1ZSNn8X5HMrL6u9L+PgNNXFXewObu2D2405sCkhFKMgJ2
rW70YN6Y6QJwNsosTUdod47e5SYsJHBQN1+s6PxBz7kvqNrLqsZwpt9OKpEv+6oW
prVBs5FCv/9Pf+LIMZ4x83zM+eZA57NMRjrkTP63UdSCyYyDvjmmBZfBhuyEDuj1
bNDlPLm5zzI7etM95gUD1Ex7CoG6U2ozCKQRan71QKUI5hHV4Q1rksTkFbLOh0Wu
LR2jBqyD8/FcZAEI3e5Z779XZoLOgJ6HkyQMs3WHiEiG7Etd1smjyjwWrGKsukdX
88qXUqKF3tHoGSbEpdSv3EcVOMi+TMoxrChb2rWnWWQZsvvJ+F8D32l3nit5zH80
GslgfokDgFKLExFs3anpz4f1iqms9JroBkosa6h/Iakh69yjrHejXfyL4PNG1u/A
rFAWczHZDlPcCLENum4T3m+4AgRpqLT2MnVxsahVKxINomRy0l1Bevt2WXLTqxzS
5+yzV6I4cpryTzx1W4XjtMvMkJ2acryb+Pyzu8l9afKWGo/TXVlmJz7WSYqZcpSB
ko61lb1KMGZ/DYjYoZhATXUNscp6Nd7aTL1zszC8tyfN5jCHZnw=
=m3Ns
-----END PGP SIGNATURE-----

--+/FtnWWBCMuQiUfl--
