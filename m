Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A15376C60E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 09:03:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbjHBHDn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 03:03:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232249AbjHBHDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 03:03:40 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D64411A;
        Wed,  2 Aug 2023 00:03:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690959820; x=1722495820;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HBcKZkQo6iBBxU7/5FTWz6bVFSXBqx52n6fTE1HOn4c=;
  b=cAEUGetbOgTjg/6JjshP+M1ezEkZTMNtPKqTzK6pGdWgGHufH65dLgTs
   sByrPBdcONGjx5vXKQh4Ji02dWOx+MqKhD9CfFdSxhTFFOFj1tJSVgLXB
   wpnOKaMYdR4hRz9yXk78KF1V/81jWthNevEosGZ7UM+gojXOiHAODxN2x
   ND6Rm/+PyVhvNI8Rjg6aYUHMdMUvZHsvmhT7Aubc0xAVcRpmsqqW0vUC6
   a2muM6arYUn69dHHnXLtVq0833AVqtkpBynlEEkkuRsNjszIPFpU/ZnR3
   La+IJBEqRWf3en1hZa3cqPJZ41hEkd+e7Hi3bawcohv6wOI+2FnuszhLq
   A==;
X-IronPort-AV: E=Sophos;i="6.01,248,1684825200"; 
   d="asc'?scan'208";a="227519945"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Aug 2023 00:02:55 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 2 Aug 2023 00:02:54 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex01.mchp-main.com
 (10.10.85.143) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 2 Aug 2023 00:02:51 -0700
Date:   Wed, 2 Aug 2023 08:02:15 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     <niravkumar.l.rabara@intel.com>
CC:     <adrian.ho.yin.ng@intel.com>, <andrew@lunn.ch>,
        <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <dinguyen@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <mturquette@baylibre.com>, <netdev@vger.kernel.org>,
        <p.zabel@pengutronix.de>, <richardcochran@gmail.com>,
        <robh+dt@kernel.org>, <sboyd@kernel.org>, <wen.ping.teh@intel.com>
Subject: Re: [PATCH v3 3/5] dt-bindings: clock: add Intel Agilex5 clock
 manager
Message-ID: <20230802-reuse-diffusion-d41ed8175390@wendy>
References: <20230801010234.792557-4-niravkumar.l.rabara@intel.com>
 <20230802025842.1260345-1-niravkumar.l.rabara@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OSO5YEP0Vw7ttOq7"
Content-Disposition: inline
In-Reply-To: <20230802025842.1260345-1-niravkumar.l.rabara@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--OSO5YEP0Vw7ttOq7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 02, 2023 at 10:58:42AM +0800, niravkumar.l.rabara@intel.com wro=
te:
> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
>=20
> Add clock ID definitions for Intel Agilex5 SoCFPGA.
> The registers in Agilex5 handling the clock is named as clock manager.
>=20
> Signed-off-by: Teh Wen Ping <wen.ping.teh@intel.com>
> Reviewed-by: Dinh Nguyen <dinguyen@kernel.org>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> Signed-off-by: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>

Damn, I was too late - you already sent a v3 :/

However, there only seems to be a v3 of this one patch and it was sent
in reply to the v2 series? The normal thing to do is resend the entire
series, not just one patch, as a new thread. Not using a new thread may
make it harder to apply & will also bury the email in people's mailboxes
that use things like mutt. A single patch as a reply is also confusing,
as the rest of the v3 looks like it is missing!

Thanks,
Conor.

--OSO5YEP0Vw7ttOq7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZMn/dwAKCRB4tDGHoIJi
0lCmAP0WWUZHTJW96EXutagjmv0LbA1yxMRnMa2fJHC2bx9AxgD/erXhYBujMC7m
6Ddqgdja2kBhffi5buudrdW23rsr3Qs=
=vX5G
-----END PGP SIGNATURE-----

--OSO5YEP0Vw7ttOq7--
