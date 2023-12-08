Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4175E80A687
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 16:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1574113AbjLHPGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 10:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574056AbjLHPGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 10:06:17 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2864CFB
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 07:06:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05F28C433C8;
        Fri,  8 Dec 2023 15:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702047983;
        bh=rxRMtllWNkL0CjKiOAHwkiWZrBIno2pyvADUXOndwAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=uR4aYLxzEuSQWQ02ya3aKNE4hsTOV2Rut8TUh4to6KvWemYgfg24xu8J5go4Vl+Vl
         JcO1oFKUoiN7MW18zZ0ikmZSw7dY2njCC586BBr42zHBi+TJIouGMZluYwCp+TQPxB
         bBy/bLNyvBsXildL7uaXKCLqeL9mKwmwMUWA70X3fkqwRdMRs/6JI+00GzQQK8MPt3
         Z/9X5kokMVkoCcCbilWFtjago8hgcSP3p5pwa0Ra55C6v2XQXICZ/ghZjEz/h7wCmU
         JIH0GUPvbPI+v1gBWIpYzbTe7gyGJyoB1f6j4WqhgdoO2xphZdYzZXPJF0Y8Scs2RZ
         /Fv30OwT+NaIQ==
Date:   Fri, 8 Dec 2023 15:06:18 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v3 4/5] dt-bindings: hwmon: Add Amphenol ChipCap 2
Message-ID: <20231208-freebase-headlock-9125c4ae6ce1@spud>
References: <20231020-topic-chipcap2-v3-0-5b3bb50a5f0b@gmail.com>
 <20231020-topic-chipcap2-v3-4-5b3bb50a5f0b@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="4aU2mKqCAe/AIpR/"
Content-Disposition: inline
In-Reply-To: <20231020-topic-chipcap2-v3-4-5b3bb50a5f0b@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4aU2mKqCAe/AIpR/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 07, 2023 at 08:44:54PM +0100, Javier Carrasco wrote:
> Add device tree bindings and an example for the ChipCap 2 humidity
> and temperature sensor.
>=20
> Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.


--4aU2mKqCAe/AIpR/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZXMw6gAKCRB4tDGHoIJi
0kunAQDl/6ji5ewuFJDegO/MbpUBGL9+a+JAYzdBR23V2icdxgD+IpA10/vOn5Lk
pE5W0DqzmbBhbQMOMsm0hPTuxbViBQU=
=LPfj
-----END PGP SIGNATURE-----

--4aU2mKqCAe/AIpR/--
