Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBB5802981
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 01:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234165AbjLDAdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 19:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234161AbjLDAdb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 19:33:31 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F007FA
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 16:33:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA749C433C8;
        Mon,  4 Dec 2023 00:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701650016;
        bh=FBE+wmFVYShGVCpLx7uHDO2IcJ2dlGbSbjadaW8ZRD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u96FDR0H+oO30Gc6/kZVY5SGUwkV6sw5vWhbObLWwBqYCE/geVOiXbyDASSVQmIN1
         nCFZkNdMh+LPpY0qBVShREbVRyKOIvQ2PG31xvfywKzBCwyx45261wGJ1d/WCrA/8P
         4ZdjbumvabO0BrWl2tzSPk4dS4YfQjARiUde2RdzreOZutCAGkOujRRvm1ych08Y8n
         eMhEMRL1e0Sp40IcKUzR9pjraVsyxMuf/1qdAjutoNpbZrLqYiD0BHSIkr5bi54Nhv
         SzZfMZFrfbP12OkE7DFCnz68i0QnrZR349Vf7oH5K4LQRNEgk1zHHAH6SCSxscDDpj
         8eOXIeobNpbzA==
Date:   Mon, 4 Dec 2023 00:33:31 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
        monstr@monstr.eu, michal.simek@xilinx.com, git@xilinx.com,
        Conor Dooley <conor.dooley@microchip.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: hwmon: Increase max number of io-channels
Message-ID: <20231204-nag-silenced-8261c06e84e4@spud>
References: <5110a313a5ce52ce6d7b5cb6b08368d42063dc30.1701419691.git.michal.simek@amd.com>
 <3d90a57d-0149-4d4b-8ffc-af26a87132a3@roeck-us.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="J39E23deplzer59T"
Content-Disposition: inline
In-Reply-To: <3d90a57d-0149-4d4b-8ffc-af26a87132a3@roeck-us.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J39E23deplzer59T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 03, 2023 at 09:15:40AM -0800, Guenter Roeck wrote:
> On Fri, Dec 01, 2023 at 09:35:00AM +0100, Michal Simek wrote:
> > The Analog Monitoring System (AMS) defines 51 channels
> > (Documentation/devicetree/bindings/iio/adc/xlnx,zynqmp-ams.yaml)
> > that's why increase number to 51.
> >=20
> > Signed-off-by: Michal Simek <michal.simek@amd.com>
> > Acked-by: Conor Dooley <conor.dooley@microchip.com>
>=20
> Applied to hwmon-next. If there are still concerns about the commit messa=
ge
> please let me know and I'll drop it until resolved.

You're good. I did ack the v1 wording even if I didn't like it, didn't
feel it was worth one resend, definitely not requesting _two_ resends.

--J39E23deplzer59T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZW0eWAAKCRB4tDGHoIJi
0kpHAPkBm6qXx16nMSZzzsahoA4H10KUF5tXA13dbIb63fKuCQEAzEjWKeOZnavV
T44EEA8kt5AfgkWCSaHxhc9RTjcYcAM=
=Jkdr
-----END PGP SIGNATURE-----

--J39E23deplzer59T--
