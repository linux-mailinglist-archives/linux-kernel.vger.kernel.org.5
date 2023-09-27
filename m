Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD91B7B082C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 17:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232449AbjI0P1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 11:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232055AbjI0P1O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 11:27:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B50E136
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 08:27:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A35E3C433C9;
        Wed, 27 Sep 2023 15:27:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695828433;
        bh=67MEpz13djP/cufNxhOgox+maC7Zu2vZGGlHmn7nedg=;
        h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
        b=mVoyV+3zNZw45lgOJmVUkEzMw+hGtRanF9TWHwcN81KjsgwDk0ROan3c0pQpcXFXn
         jO68UEBWV7+83qlrvmwUt97dU2oIxijgm5Jg4wXeF0tmuuphHwb5mM37J2Ie+PMyMX
         rVomAhSN6Eb74LzpGyy83M2om1fVqhr413PqmYMbzzAsE31HkPQ+LP5rw0+9wHSEwn
         SX9W6wHVAVLtxncMTJt2Vq25YVtdmuq2sNRcgXRwyNEtzMBIrrgWbTDG/toekTXpjr
         2b7gxZoNH5y4EbMpLYweeVbEhCXn/ucg9dCfHhPZ4JWNXvpUNPWMjNuzh1MchYTOno
         X2TZCmZ2Xe9pA==
Message-ID: <d891e81aa464193e9989b3be1ecbf784.mripard@kernel.org>
Date:   Wed, 27 Sep 2023 15:27:10 +0000
From:   "Maxime Ripard" <mripard@kernel.org>
To:     "Douglas Anderson" <dianders@chromium.org>
Subject: Re: [PATCH] MAINTAINERS: Document that the NXP i.MX 8MQ DCSS driver
 goes thru drm-misc
In-Reply-To: <20230925154929.1.I3287e895ce8e68d41b458494a49a1b5ec5c71013@changeid>
References: <20230925154929.1.I3287e895ce8e68d41b458494a49a1b5ec5c71013@changeid>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        "Laurentiu Palcu" <laurentiu.palcu@oss.nxp.com>,
        "Maxime Ripard" <mripard@kernel.org>
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sep 2023 15:49:29 -0700, Douglas Anderson wrote:
> As per the discussion on the lists [1], changes to this driver
> generally flow through drm-misc. Add a tag in MAINTAINERS to document
> this
>=20
> [1] https://lore.kernel.org/r/20230925054710.r3guqn5jzdl4giwd@fsr-ub1664-=
121.ea.freescale.net
>=20
> [ ... ]

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
