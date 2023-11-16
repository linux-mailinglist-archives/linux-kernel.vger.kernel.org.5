Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C14457EE2D0
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 15:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbjKPOa1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 09:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjKPOaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 09:30:24 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 997CCD4B
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 06:30:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7ADFC433C8;
        Thu, 16 Nov 2023 14:30:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700145020;
        bh=hOIVPvdhoBjFYKhZmULCCqOEbzSpvXG69XSPRnCcnc0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hEvYKp6tn+edJXFASdLS/4hWvLo1b/esOxXyhHMo0UM/FDr+10bpe/WwnV7H3Ik70
         lIcurmbMrf9VqoPOKZ64HHuZUdC2luHb19tjIRf3a/tKdvKD4XBdXGVTZkkqb0B2po
         Z13GuuU/892TnfQJKEI4mYrKrSpYTUQmii6tpTF8pRye4wBrl4P5mICxCJFhZJOrHT
         mS4FQxcOQp7833BkOg4fBy8pESRBK7V+4iZcAPwgcUWGH9xFVy4JyBXFF2LDFgUybw
         zuhM80oCmmO+N9uqr9yi+GTwuCLjugRvstlJ2gcKzYeYl1lqLlf61qxSI1R7+gpPsJ
         i+Mq60EfYRh1A==
Date:   Thu, 16 Nov 2023 14:30:17 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-i2c@vger.kernel.org,
        linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v5 1/2] dt-bindings: hwmon: Add lltc ltc4286 driver
 bindings
Message-ID: <20231116-iodize-wildfowl-f5d72c182658@squawk>
References: <20231116023027.24855-1-Delphine_CC_Chiu@Wiwynn.com>
 <20231116023027.24855-2-Delphine_CC_Chiu@Wiwynn.com>
 <caff5743-265f-43ac-83fb-4e0fb23a9ff4@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="lStQTFIwxdtm5lrO"
Content-Disposition: inline
In-Reply-To: <caff5743-265f-43ac-83fb-4e0fb23a9ff4@linaro.org>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--lStQTFIwxdtm5lrO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 16, 2023 at 01:13:58PM +0100, Krzysztof Kozlowski wrote:
> On 16/11/2023 03:30, Delphine CC Chiu wrote:
> > Add a device tree bindings for ltc4286 device.
> >=20
> > Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@Wiwynn.com>
> >=20
> > -------------------------------------------------------------
> > Changelog:
> >   v5 - Add hyphen under "Changelog" in commit message
>=20
> Apply your patch from the list and check the result... You can easily
> see it's broken. We asked about ---. Please read the message carefully.

My reviewed-by was also omitted again, but I suppose that is a good
thing since I conditionally gave that based on the changelog being
fixed!

--lStQTFIwxdtm5lrO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVYndQAKCRB4tDGHoIJi
0g9pAQDuDPX4/eIC8rfODFMv4qArSDILjwy36Q/U/4fiERcTpgEA3Z9fHBFWkFKS
oJYaFHnrTAdjn3WnmV9MY9RcWT6kIQY=
=akaG
-----END PGP SIGNATURE-----

--lStQTFIwxdtm5lrO--
