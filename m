Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9AC377B937
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 15:00:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjHNNAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 09:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjHNM7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:59:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D6EE52
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 05:59:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E6CC1650CC
        for <linux-kernel@vger.kernel.org>; Mon, 14 Aug 2023 12:59:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39074C433C9;
        Mon, 14 Aug 2023 12:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692017982;
        bh=LtHqR4yNgL7Btue5s0Mfv0totgeNy96+M5aN+/ZFmOA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Psu8xsv6NXwtYJGq1c6t9ibfBp5frUF8sSiU+GCqLVaVq7hNXs1EFCE1HTqYHlz/U
         KXM9uxOfO0KmIzuBB/P9LhIQeLLGRvuKHJB8LUwm+yV9h+IsLTdx9COxZWdIu5vi0F
         9k04ShCArOCiGQYNXyv4Jh+yw6DASwZMcDFH/xZwJIEE8rApUEV/x0IEVm9xii8yAc
         dtXHjJhvXPLgd56dWDzh87AzFFeJ9pNcY99xNEwUB8t2muuPlsyfj17A+tHstQCRjb
         SmbIAGUMmo7u0tvLJDD3QTruDgrWuxC5frFNuQlm4zHA0HbERcC3iLWNwHtPL7ieNT
         6Gw3VjSDrYO9Q==
Date:   Mon, 14 Aug 2023 13:59:37 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 18/25] ASoC: component: Add generic PCM copy ops
Message-ID: <aa76de2e-0734-449f-bd46-afae43b8ff01@sirena.org.uk>
References: <20230814115523.15279-1-tiwai@suse.de>
 <20230814115523.15279-19-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="grZUougk9zWM0gy0"
Content-Disposition: inline
In-Reply-To: <20230814115523.15279-19-tiwai@suse.de>
X-Cookie: FACILITY REJECTED 100044200000
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--grZUougk9zWM0gy0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 14, 2023 at 01:55:16PM +0200, Takashi Iwai wrote:
> For following the ALSA PCM core change, a new PCM copy ops is added
> toe ASoC component framework: snd_soc_component_driver receives the
> copy ops, and snd_soc_pcm_component_copy() helper is provided.

Reviewed-by: Mark Brown <broonie@kernel.org>

--grZUougk9zWM0gy0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmTaJTkACgkQJNaLcl1U
h9CM6wf/T4m+QpauBQO3eir95Qj1RcDkydZq9yBmkQcHwR9GEJgvGMmK1jvm839j
cxaYzdvdiwTvC27YarOEPKMhEG+g5Q854av7iyti5cwukGvXGwqmScCH7wbAQWTz
eI81f1t7wa58sKuxUZ8s/DZG+l4ZEEdWB9LbN38/ZrB5qYlQ9jEujGUaA7wIEXEJ
NlmlFHJywQ62z3tHIM4WPDJw+soRy4r9x7HX0yxwKdsHerk43Rai6pIrcWEz6Hii
7mau+k/+PyrO/7yA0QuaG2kla/Kd/oVgNZMQ9kdIrSXl+TuDPpa0kba99K8WtXvl
J2Ar6sfL4BxaEil3OjpT7H7ByuF1xA==
=X7du
-----END PGP SIGNATURE-----

--grZUougk9zWM0gy0--
