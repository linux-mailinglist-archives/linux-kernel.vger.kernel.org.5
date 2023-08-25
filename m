Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71E7A789261
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 01:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbjHYXdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 19:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231182AbjHYXdB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 19:33:01 -0400
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6442109
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 16:32:53 -0700 (PDT)
Date:   Fri, 25 Aug 2023 23:32:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1693006370; x=1693265570;
        bh=zRwWsMDd5Kf2yQpedEA3Ka2dLpgNvYvwuOL0uYq4mxY=;
        h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
         Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID:BIMI-Selector;
        b=nZFuiL4fW85fX+J1npo65OvHYrgHnoS8wSxqWSLrKmoviM0c6e46mqRMzqtH9/MWu
         Vby1zVLEV0v/ulasBpcymNz1VfCpTci/snqcsPRf5HetuWyoT192nAqyslEZTGXVBm
         qQEZzX/jRVgKdtvqS8j220WQfCl7vsOeojSW+cUAESI7H86M5acLyHKT2ym01QEojV
         0H9Z1Sf9+IzBBykN4SLirksIOs6h5MkowLtmccM1RA2sesJXM3MKtTal8HGNPLCDuw
         w+pqX7j7stkvcSKTbFHEQgDUzFkJHctAIZbQIIUO8A1aM+EYeAI+W3EFFqrF+PxMcN
         fJYTsLcLeC7nQ==
To:     Stephen Boyd <swboyd@chromium.org>
From:   Simon Ser <contact@emersion.fr>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, dri-devel@lists.freedesktop.org,
        Pekka Paalanen <pekka.paalanen@collabora.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: Re: [PATCH] drm/connector: Add newline to debug printk
Message-ID: <sqyPw9vZ5TuRr6bQT59K00AB1wM5QdkEdK-qUEWeesjx_nin5LzSAL1NSIOIV5PD0pKqpzqscQs0FRAjMmD98L3WcNMt4-l7J0mxqIMr7zQ=@emersion.fr>
In-Reply-To: <20230825233118.2689222-1-swboyd@chromium.org>
References: <20230825233118.2689222-1-swboyd@chromium.org>
Feedback-ID: 1358184:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,T_SPF_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Simon Ser <contact@emersion.fr>
