Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EAB67ED1DB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 21:14:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344282AbjKOUOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 15:14:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbjKOUOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 15:14:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4C7B8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 12:14:38 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5F14C433C8;
        Wed, 15 Nov 2023 20:14:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700079278;
        bh=u27jYiyCnPvX7BwcogXqTwm0JCokegPD0Pe+zFt7/vk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TiQsJcibVMrhAUxdRs4u55T1ZRdXUaqXl0B5FwM1xxy95CP56AwkQ1rDOe8a9oRoM
         Z8/1VADpjkogA5+7sakttqxM+FIdPYZCb6phOXReJyup0qXLXDxcDlBED2qrZ9pEK/
         5d23ZF8mirTogRa0OaIJ6zSozfBveBNkof79iV0xhe4z7yoIHnXwn6mqxh1h426RzR
         5BDgd7OCfpaenn5yZ96T8LtORT8jEzmRim8o1D82D5BBkWn0IBuHnMgWvXhB4dr07X
         VKcfkO78iZsKEchmMDJOT0SGiuzm2EaZdxuf33hGEk96KPL2GK8EUKga0NP+ACePHB
         q4fkFIRbfc2mw==
Date:   Wed, 15 Nov 2023 20:14:32 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Flavio Suligoi <f.suligoi@asem.it>
Cc:     Lee Jones <lee@kernel.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>,
        Helge Deller <deller@gmx.de>, Pavel Machek <pavel@ucw.cz>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 1/2] dt-bindings: backlight: mp3309c: remove two
 required properties
Message-ID: <20231115-showdown-blame-06a9acb63506@squawk>
References: <20231115152902.851715-1-f.suligoi@asem.it>
 <20231115152902.851715-2-f.suligoi@asem.it>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7YInnrzDKNO+YsB+"
Content-Disposition: inline
In-Reply-To: <20231115152902.851715-2-f.suligoi@asem.it>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--7YInnrzDKNO+YsB+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 15, 2023 at 04:29:01PM +0100, Flavio Suligoi wrote:
> Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>

You omitted my ack that I gave on the previous version.
Acked-by: Conor Dooley <conor.dooley@microchip.com>

Cheers,
Conor.

--7YInnrzDKNO+YsB+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZVUmpQAKCRB4tDGHoIJi
0qqQAP48sZ0PpimqIgeXVDtIsAnRBgLRK6J12gcofe0rmm2dTQEA6AsQB7AwImc8
T8U4C7CkANMlEQvcOu1fB5Bl5KkzKgw=
=Z3fk
-----END PGP SIGNATURE-----

--7YInnrzDKNO+YsB+--
