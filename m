Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7C579A0C8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Sep 2023 02:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbjIKA1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Sep 2023 20:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbjIKA1Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Sep 2023 20:27:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C3C91B9;
        Sun, 10 Sep 2023 17:27:10 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09170C433C8;
        Mon, 11 Sep 2023 00:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694392029;
        bh=0UCzLWCstL0ZopkfUvL7PD9fXTOv7H97Mq5oqvfgZMg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mBsrGQ4FW8p0UiM62eD2lMn8pWT46uHV9MZa/y7V1d9EQ3G+2VWIWrldg7u7n37kA
         HTa076iojmbLk7sp0Ds4/niJfEhiY2YxKK5ZS8n+xI+H/Pm2EiKytFseLr7YP8b1lF
         477ksczLfK7j52D0tOXZmeYwXHHE1iUcp3vVlqb0o2iWypjUAfVoyRjbJ0X1RKgyX2
         XxLj1ldJW1mARf5nXRk3TJDbezhj6utvPO8oYSO70dc4qgu+EKI0OShvdvCh6as7Sk
         xuxIMRRJMFTm7qh1+4Fmn4f2IhMM7aKJUE3XrAbPUT2xN9YSuVUCB6geClR8tAQ6QI
         FGG8JV0YrCbBQ==
Date:   Mon, 11 Sep 2023 01:27:05 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Vlad Karpovich <vkarpovi@opensource.cirrus.com>
Cc:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 4/4] ASoC: cs35l45: Add AMP Enable Switch control
Message-ID: <ZP5e2X4hry+KJZ+B@finisterre.sirena.org.uk>
References: <20230831162042.471801-1-vkarpovi@opensource.cirrus.com>
 <20230831162042.471801-4-vkarpovi@opensource.cirrus.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3v04NETlEyGouWXO"
Content-Disposition: inline
In-Reply-To: <20230831162042.471801-4-vkarpovi@opensource.cirrus.com>
X-Cookie: The revolution will not be televised.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3v04NETlEyGouWXO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 31, 2023 at 11:20:42AM -0500, Vlad Karpovich wrote:
> The "AMP Enable Switch" is useful in systems with multiple
> amplifiers connected to the same audio bus
> but not all of them are needed for all use cases.

This doesn't apply against current code, please check and resend.

--3v04NETlEyGouWXO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmT+XtgACgkQJNaLcl1U
h9CsSQf8CiKjWm47l3WLdJRNU7NpvghNrr3Kd3iwsR/IIaAAu28HHVCn4iUxhBQB
m69fo+G8p7WxhuXcwXL39yHiyK0xD4E8kc5vXfQjf5CfEh4Im36piOtiQnqiSoLF
Ld3mZ5J8ayM4bgaHkxLmQ7a/iNHFlpNsv6Mi5jEbS8yQCakSPzzqQU1WROu//hAV
Pc0SdrBELUZ6+7hJBFuBOertUBHy92KEV1+JYUOa5xuyydgxJv3yHWLdobG/Qm/9
R10rixSechOrb2x4O77s3L1ZSWABaMysUs7tH6yBuL0ru+xnSMmEKtGYCUF+0YK7
GQQq6EJsuTTElsiB94ZFy1/JBoThSQ==
=tOc1
-----END PGP SIGNATURE-----

--3v04NETlEyGouWXO--
