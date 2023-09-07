Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE0D9797A14
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 19:29:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234130AbjIGR3o convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 7 Sep 2023 13:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbjIGR3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 13:29:42 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D56A1716
        for <linux-kernel@vger.kernel.org>; Thu,  7 Sep 2023 10:29:14 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1qeE52-0003uW-22; Thu, 07 Sep 2023 14:25:52 +0200
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1qeE51-004eFm-Fz; Thu, 07 Sep 2023 14:25:51 +0200
Received: from pza by lupine with local (Exim 4.96)
        (envelope-from <p.zabel@pengutronix.de>)
        id 1qeE50-000AUQ-2p;
        Thu, 07 Sep 2023 14:25:50 +0200
Message-ID: <6ad4d61247365ead2f93c6ddb450de73d4be0ab2.camel@pengutronix.de>
Subject: Re: [PATCH] MAINTAINERS: Update DRM DRIVERS FOR FREESCALE IMX entry
From:   Philipp Zabel <p.zabel@pengutronix.de>
To:     Douglas Anderson <dianders@chromium.org>,
        dri-devel@lists.freedesktop.org
Cc:     Maxime Ripard <mripard@kernel.org>, linux-kernel@vger.kernel.org
Date:   Thu, 07 Sep 2023 14:25:50 +0200
In-Reply-To: <20230906072803.1.Idef7e77e8961cbeb8625183eec9db0356b2eccd0@changeid>
References: <20230906072803.1.Idef7e77e8961cbeb8625183eec9db0356b2eccd0@changeid>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
User-Agent: Evolution 3.46.4-2 
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mi, 2023-09-06 at 07:28 -0700, Douglas Anderson wrote:
> As per the discussion on the lists [1], changes to this driver
> generally flow through drm-misc. If they need to be coordinated with
> v4l2 they sometimes go through Philipp Zabel's tree instead. List both
> trees in MAINTAINERS. Also update the title of this driver to specify
> that it's just for IMX 5/6 since, as per Philipp "There are a lot more
> i.MX that do not use IPUv3 than those that do."
> 
> [1] https://lore.kernel.org/r/d56dfb568711b4b932edc9601010feda020c2c22.camel@pengutronix.de
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>

Thank you,
Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
