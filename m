Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6834759A67
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 18:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbjGSQCs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 12:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229626AbjGSQCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 12:02:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A65519A6;
        Wed, 19 Jul 2023 09:02:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DD11D61759;
        Wed, 19 Jul 2023 16:02:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93D6AC433C8;
        Wed, 19 Jul 2023 16:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689782556;
        bh=sDuKV/AjKrQtJ8swPHqAanif92az3Y09omQ2JTBSqmg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LWGRcfjkEO9TzC9+HtugvE4mSwxDUi90BrhwxBg18GfJmY2VVDlGEcGV1dXDXMnmB
         zYERw9tsRqEEGC9XNcg9KEprvggdb8jtuN8DfDU4cCr7cj3xAtC17tCvje6a/uuEOy
         3iUXcDFBMEHzsvULB2ssJGDcMCpeWFzOk5a4NREs/FA8QCo8dR+r//t/VD7odIgfM6
         cuYPLi/QWgki7Qcw14a3R9v3JSraSzsNjRn5HMfs9d9lMXr7Dn37rx87EQN482Tv1z
         n0AA1YEJ1XBf/usNidv0Z2IMF3NCwq6RG83Nt19e9djSEeJ2wMYVNp7PD/Q2dn1XsI
         TR8B5RaFE0VZw==
Date:   Wed, 19 Jul 2023 17:02:30 +0100
From:   Conor Dooley <conor@kernel.org>
To:     "Potthuri, Sai Krishna" <sai.krishna.potthuri@amd.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        "Simek, Michal" <michal.simek@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        "Shah, Tanmay" <tanmay.shah@amd.com>,
        "Levinsky, Ben" <ben.levinsky@amd.com>,
        Marek Vasut <marex@denx.de>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Arnd Bergmann <arnd@arndb.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "saikrishna12468@gmail.com" <saikrishna12468@gmail.com>,
        "git (AMD-Xilinx)" <git@amd.com>
Subject: Re: [PATCH 3/4] dt-bindings: pinctrl-zynqmp: Add output-enable
 configuration
Message-ID: <20230719-brunette-prelaw-1c154002de1e@spud>
References: <20230717093347.3869167-1-sai.krishna.potthuri@amd.com>
 <20230717093347.3869167-4-sai.krishna.potthuri@amd.com>
 <20230718-jitters-excretion-fe18c820c102@spud>
 <BY5PR12MB4258543534215430BC2F8FA3DB39A@BY5PR12MB4258.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BDFCLUw9LmXsQDa4"
Content-Disposition: inline
In-Reply-To: <BY5PR12MB4258543534215430BC2F8FA3DB39A@BY5PR12MB4258.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--BDFCLUw9LmXsQDa4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 19, 2023 at 06:49:43AM +0000, Potthuri, Sai Krishna wrote:
> Hi Conor,
>=20
> > -----Original Message-----
> > From: Conor Dooley <conor@kernel.org>
> > Sent: Tuesday, July 18, 2023 9:20 PM
> > To: Potthuri, Sai Krishna <sai.krishna.potthuri@amd.com>
> > Cc: Linus Walleij <linus.walleij@linaro.org>; Simek, Michal
> > <michal.simek@amd.com>; Rob Herring <robh+dt@kernel.org>; Krzysztof
> > Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
> > <conor+dt@kernel.org>; Mathieu Poirier <mathieu.poirier@linaro.org>; Sh=
ah,
> > Tanmay <tanmay.shah@amd.com>; Levinsky, Ben <ben.levinsky@amd.com>;
> > Marek Vasut <marex@denx.de>; Roman Gushchin <roman.gushchin@linux.dev>;
> > Arnd Bergmann <arnd@arndb.de>; linux-arm-kernel@lists.infradead.org; li=
nux-
> > kernel@vger.kernel.org; linux-gpio@vger.kernel.org; devicetree@vger.ker=
nel.org;
> > saikrishna12468@gmail.com; git (AMD-Xilinx) <git@amd.com>
> > Subject: Re: [PATCH 3/4] dt-bindings: pinctrl-zynqmp: Add output-enable
> > configuration
> >=20
> > On Mon, Jul 17, 2023 at 03:03:46PM +0530, Sai Krishna Potthuri wrote:
> > > Add 'output-enable' configuration parameter to the properties list.
> > >
> > > Using these pinctrl properties observed hang issues with older Xilinx
> > > ZynqMP Platform Management Firmware, hence reverted the patch previou=
sly.
> > > Commit ff8356060e3a5e126abb ("Revert "dt-bindings: pinctrl-zynqmp: Add
> > > output-enable configuration"").
> >=20
> > And what has changed since then that makes it okay to add?
> > Is the old firmware not still in the wild?
> This time when Linux firmware driver get the request for TRISTATE configu=
ration
> from pinctrl driver, it checks if that configuration is supported by the =
Xilinx ZynqMP
> Platform Management firmware. If yes, then calls will be made otherwise i=
t returns error.

Please put that information in your commit message. With that done,
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Thanks,
Conor.

--BDFCLUw9LmXsQDa4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZLgJFgAKCRB4tDGHoIJi
0h0YAQDslSWYW+0mKcsLpxUx7oCTtaRONNKJV3ZkEyPKShepTwD+JfE/Cea4UZEU
xg6tso+P6vUo1jtUS50W65hbKzJ3vA8=
=kKBy
-----END PGP SIGNATURE-----

--BDFCLUw9LmXsQDa4--
