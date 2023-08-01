Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B19D76B92A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 17:54:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234218AbjHAPyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 11:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbjHAPy3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 11:54:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35FC1B2;
        Tue,  1 Aug 2023 08:54:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 490A261602;
        Tue,  1 Aug 2023 15:54:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1709EC433C8;
        Tue,  1 Aug 2023 15:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690905266;
        bh=YTzEex3MrsIyDif+LvWblgzD2IiqUMw1PvPWVyIP5XE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KBmNRYAAgpUp0cM58UfU95iiVTOQTs7Xj/HMrsf/cDa0yeS14/nG5xZv2R5sLBr9K
         UwyZxNK/6t7zYIBcfJBsAr1sHPXGNMCm69BMUj4pRErj4KXJSAeXgIZCeFzz6dq+5x
         g7543dFXFtsbW9RHas7xwHJFQgngDmeRj28rbd4W9g4q+/7FVR5j1PjEJCJm/uLYXr
         GZizlotK6PtA8FoH/e7zmGRbEdW8UpPDvyWVrdYzAK2kUl6ziNT8vpA8dWlPxATbrg
         rk7miwODq+6Z/Tc+SnrljDn91sN3h/VpbMsGm6mbgQC9JG2O717DHF/Q5KmZvjZbnq
         OW74DewioDhjg==
Date:   Tue, 1 Aug 2023 16:54:21 +0100
From:   Conor Dooley <conor@kernel.org>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jianmin Lv <lvjianmin@loongson.cn>, wanghongliang@loongson.cn,
        Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v2 1/2] gpio: dt-bindings: add parsing of loongson gpio
 offset
Message-ID: <20230801-varsity-chemo-09cc5e250ded@spud>
References: <20230731091059.17323-1-zhuyinbo@loongson.cn>
 <20230731091059.17323-2-zhuyinbo@loongson.cn>
 <20230731-setback-such-61815ee3ef51@spud>
 <041bf8a6-8d91-c2ce-6752-aa7255f946c7@loongson.cn>
 <20230801-whenever-imitation-b2759b212f6b@spud>
 <a5c27913-2a88-d376-0130-22ca8a3d4516@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0s9XzvurofOEngPf"
Content-Disposition: inline
In-Reply-To: <a5c27913-2a88-d376-0130-22ca8a3d4516@loongson.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--0s9XzvurofOEngPf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 01, 2023 at 04:34:30PM +0800, Yinbo Zhu wrote:
>=20
>=20
> =E5=9C=A8 2023/8/1 =E4=B8=8B=E5=8D=883:23, Conor Dooley =E5=86=99=E9=81=
=93:
> > On Tue, Aug 01, 2023 at 02:39:49PM +0800, Yinbo Zhu wrote:
> > >=20
> > >=20
> > > =E5=9C=A8 2023/7/31 =E4=B8=8B=E5=8D=8811:55, Conor Dooley =E5=86=99=
=E9=81=93:
> > > > On Mon, Jul 31, 2023 at 05:10:58PM +0800, Yinbo Zhu wrote:
> > > > > Add parsing GPIO configure, input, output, interrupt register off=
set
> > > > > address and GPIO control mode support.
> > > >=20
> > > > This reeks of insufficient use of SoC specific compatibles. Do GPIO
> > > > controllers on the same SoC have different register offsets?
> > >=20
> > >=20
> > > Yes,
> > >=20
> > > > Where are the users for this?
> > >=20
> > >=20
> > > For example, ls2k500 contains multiple GPIO chips with different
> > > (configure, input, output, interrupt) offset addresses, but all others
> > > are the same.
> >=20
> > Right. That's admittedly not what I expected to hear! Can you firstly
> > explain this in the commit message,
>=20
>=20
> I will add following explain in the commit message. Do you think it's
> suitable?
>=20
> Loongson GPIO controllers come in multiple variants that are compatible
> except for certain register offset values.  Add support in yaml file for
> device properties allowing to specify them in DT.

Sure, that would be helpful.=20

> > and secondly add a soc-specific
> > compatible for the ls2k500 and only allow these properties on that SoC?

> Sorry, I may not have described it clearly before, the ls2k500 was only
> as a example, actually, Loongson GPIO controllers (2k500,2k1000,eg)come
> in multiple variants that are compatible except for certain register
> offset values.  So above all offset device property was used to in all
> loongson gpio controller.

But it would be good to know why they are different. Do they each
support some different features, or was there some other reason for
making controllers like this?

Thanks,
Conor.

--0s9XzvurofOEngPf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMkqrQAKCRB4tDGHoIJi
0rYYAQCmEdeLBYxTd7t+7RjsCTt/+pN/qYxgXaG+jYXcxYXKbwD/XQzcWjqQVCtU
+5Isrwhco0IFgjMo79+uFRBfy5RVSQc=
=fUqV
-----END PGP SIGNATURE-----

--0s9XzvurofOEngPf--
