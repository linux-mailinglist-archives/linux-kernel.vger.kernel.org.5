Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4B77AD238
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 09:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232632AbjIYHqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 03:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbjIYHps (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 03:45:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5C0C1706
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 00:45:21 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A379C433CA;
        Mon, 25 Sep 2023 07:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695627921;
        bh=d5HRu8E3T8PlMucp89AFZaeFnM4xuCGURMulBdsftuc=;
        h=Date:From:To:Subject:In-Reply-To:References:Cc:From;
        b=AuDrplQfoyK0oYMpRBAWhHQgA4eO3/i7blRD2DiY4zqJpwDHJ8OfudMcercfjTF/G
         qqOkunfDb4A2g3pnsIoDzQcfMPIVCUjF8UJdWsXDm1y2wgmqrzpmz68jQHU1x69Lqr
         +0djr1b3TPFEM6hOM2jjKxXYclpnzMSJEiRcQy4QbuAecDOGjE4WlljnUEARzPanlW
         IwjeQAvLJVmRQ+xbc3AaQga2VR9tS9KYFYHj54nWrI69Z3lgmqhv+gIf2kusfyk1n8
         kDASnZmplaV9PgubXpW67Y9CQY+7qOudbuxneBx/DlwCHsRnhSxOCagrI2SD+y9l4F
         ckFy7PnfeC+Dg==
Message-ID: <50beeef703d81daeb00599b60ecdfa61.mripard@kernel.org>
Date:   Mon, 25 Sep 2023 07:45:18 +0000
From:   "Maxime Ripard" <mripard@kernel.org>
To:     "Jernej Skrabec" <jernej.skrabec@gmail.com>
Subject: Re: [PATCH 4/7] drm/sun4i: Don't show error for deferred probes.
In-Reply-To: <20230924192604.3262187-5-jernej.skrabec@gmail.com>
References: <20230924192604.3262187-5-jernej.skrabec@gmail.com>
Cc:     airlied@gmail.com, daniel@ffwll.ch,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, mripard@kernel.org,
        samuel@sholland.org, wens@csie.org,
        "Maxime Ripard" <mripard@kernel.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 24 Sep 2023 21:26:01 +0200, Jernej Skrabec wrote:
> Drivers probing in display pipeline can be deferred for many reasons.
> Don't print error for such cases.
> 
> Signed-off-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Acked-by: Maxime Ripard <mripard@kernel.org>

Thanks!
Maxime
