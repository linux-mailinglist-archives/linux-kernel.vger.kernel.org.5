Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A312A7979DC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbjIGRXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 13:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236830AbjIGRXV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:23:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170531FCA
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:22:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97C61C433C8;
        Thu,  7 Sep 2023 17:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694107317;
        bh=XlJDbU1PykwszLckIDeqTgZVj8n/v3RikjI/YqwqCDA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p0/oYw03EZZzSTmukYBCAvlRQoG3dUkXObbI08zjrlWK6Oy/YhuBuhaSvQ87M37Eo
         zPwzWt7GqDW+AO5NOgcRNe4gaDQ986thcklUFGm6lUJPyN+fjI9ruBqgQyN172nS83
         5B6cvq/I9qSC/4rR/Rii8bKiqaEb2u9DOCQTBd7TGQBN23Pg5xHJQwVy62WeF97wpC
         MW4d4jQEXORyXQj4Pc5DPRMwgDtJ3Ia0ZrRARdtH6s46WqibxtfbUDPnvA0kPVsSra
         2aRf3487ENrAFAY5rm88EoLIi9EWxuVFWbeT9WG4Vkz9Gmk8BPUWMf4thVRntEaDSl
         bwzF7PA8IFg5A==
Date:   Thu, 7 Sep 2023 18:21:51 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Cc:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Vitaly Rodionov <vitalyr@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v2 00/11] Improve CS35l41-based audio codec drivers
Message-ID: <4a658238-b5cf-44fc-802b-f09f8d5e0ad1@sirena.org.uk>
References: <20230907171010.1447274-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XvuXBREcYlQzjp52"
Content-Disposition: inline
In-Reply-To: <20230907171010.1447274-1-cristian.ciocaltea@collabora.com>
X-Cookie: In the next world, you're on your own.
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--XvuXBREcYlQzjp52
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Sep 07, 2023 at 08:09:59PM +0300, Cristian Ciocaltea wrote:

>  - Added 3 new patches providing some HDA related fixes

Do these have any interaction with the rest of the series?

--XvuXBREcYlQzjp52
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmT6Bq4ACgkQJNaLcl1U
h9DHogf/RF1H5pI87OixXP/jRxp2mAsLVLGaQ3RjIJTi00LPr5TJEv455keNqxGU
ZGFv0gPvJ7j2ja/Psu23ZBlcgoeI/y9sVaQbaISTw1bUXIXdxRPDjIQrbzuw0Tpp
/K/89ROxmK3I2xwZ2IzBZwwb4jE2Jlxr96Q5EaFlU0gJpWQFOVzGmeymAwgCmS1E
qLJg+jqf++xxUvPgcM+l5J86srsE597mf2lVwsR5532JeJBQ/smC+vrBFihdQLNP
ALnftYbhT+18pdhP0xPVaErBhX65xOYLCwYHt1Q3Pjt5GDQvorWG2hF4S6aFBQIa
vQYudyD/Fn8U1qdPFn3xssF9p6x6pw==
=vXsG
-----END PGP SIGNATURE-----

--XvuXBREcYlQzjp52--
