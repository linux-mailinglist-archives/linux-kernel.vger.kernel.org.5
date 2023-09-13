Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB32879E847
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 14:48:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234847AbjIMMsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 08:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231132AbjIMMse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 08:48:34 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5AD2519B4;
        Wed, 13 Sep 2023 05:48:30 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id C1E9F8088;
        Wed, 13 Sep 2023 12:48:29 +0000 (UTC)
Date:   Wed, 13 Sep 2023 15:48:28 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     Andreas Kemnade <andreas@kemnade.info>, airlied@gmail.com,
        daniel@ffwll.ch, u.kleine-koenig@pengutronix.de, arnd@arndb.de,
        laurent.pinchart@ideasonboard.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [RFC PATCH] drm: omapdrm: dsi: add refsel also for omap4
Message-ID: <20230913124828.GL5285@atomide.com>
References: <20230913065911.1551166-1-andreas@kemnade.info>
 <48972ab0-e4ed-11b2-31fb-ad93695a4db1@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48972ab0-e4ed-11b2-31fb-ad93695a4db1@ideasonboard.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> [230913 12:11]:
> I'm somewhat sure that the upstream driver used to work on omap4 sdp, which
> has two DSI panels. But I can't even remember what omap4 version it had.

I think those were both dsi command mode panels though, not video mode?

Regards,

Tony
