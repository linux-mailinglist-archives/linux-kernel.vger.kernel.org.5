Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA5879EF69
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 18:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjIMQwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 12:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbjIMQwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 12:52:19 -0400
Received: from mail.andi.de1.cc (mail.andi.de1.cc [IPv6:2a02:c205:3004:2154::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FD5B7;
        Wed, 13 Sep 2023 09:52:14 -0700 (PDT)
Received: from [2a00:20:4004:4787:9869:7b20:a1ae:be54] (helo=akphone)
        by mail.andi.de1.cc with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <andreas@kemnade.info>)
        id 1qgT5y-003grq-Gl; Wed, 13 Sep 2023 18:52:06 +0200
Date:   Wed, 13 Sep 2023 18:52:02 +0200
From:   Andreas Kemnade <andreas@kemnade.info>
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch, u.kleine-koenig@pengutronix.de,
        arnd@arndb.de, laurent.pinchart@ideasonboard.com,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>
Subject: Re: [RFC PATCH] drm: omapdrm: dsi: add refsel also for omap4
Message-ID: <20230913185202.6e6c5341@akphone>
In-Reply-To: <48972ab0-e4ed-11b2-31fb-ad93695a4db1@ideasonboard.com>
References: <20230913065911.1551166-1-andreas@kemnade.info>
        <48972ab0-e4ed-11b2-31fb-ad93695a4db1@ideasonboard.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; aarch64-alpine-linux-musl)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2023 15:11:08 +0300
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com> wrote:

> On 13/09/2023 09:59, Andreas Kemnade wrote:
> > Some 3.0 source has it set behind a if (omap4).
> > Maybe it is helpful maybe not, at least in the omap4460
> > trm these bits are marked as reserved.
> > But maybe some dsi video mode panel starts magically working.  
> 
> Sorry, what does this mean? That this fixes something, or you are
> just guessing?
> 
just diffing registers between good and bad. It does not fix anything,
just reducing the diff.

> I'm somewhat sure that the upstream driver used to work on omap4 sdp, 
> which has two DSI panels. But I can't even remember what omap4
> version it had.
> 
after we are using displays from gpu/drm/displays?

Regards
Andreas
