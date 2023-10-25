Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530E97D7293
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 19:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232808AbjJYRpg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 13:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJYRpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 13:45:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97E1ACC;
        Wed, 25 Oct 2023 10:45:32 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7044AC433C8;
        Wed, 25 Oct 2023 17:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698255932;
        bh=qTeZ6U7qAakYJ5XSVziQjOqbVXvEjhzJrKi9js8BYMM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=JA2vsm3KZDI7mSCKzD2QFZOytcyrITQhbUSA8OHuHI/8/zTl2A9PYdIF3stYRtwZh
         xKwPOeFfoYD8YNsNvT1trJ48+eEc43CJ8Bus6D7FI+76l9d3qRCr79uziGgAErH55Z
         KKpXeKu98GSAvncDZjrIktu1Sb//Ey5ztRnlgv0UdN6/uoD4SNIKMs4BY16d8G9Wev
         vkCx9lQXIFlJrzbzDaV35nJ0BZg5fDgONqfjkvsAGPEnGBfhsg8WcyBL39QTHQM0hr
         jy5u4fEcl0gxnwOOYiQAY8XzFduA3wicrMm/yfZoLIXPU6ywMNzzOvvmvgkUY/Kha5
         zxhiFru7sCMyw==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH wireless-next 1/2] wifi: ray_cs: Remove unnecessary
 (void*)
 conversions
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231020093432.214001-1-yunchuan@nfschina.com>
References: <20231020093432.214001-1-yunchuan@nfschina.com>
To:     Wu Yunchuan <yunchuan@nfschina.com>
Cc:     Wu Yunchuan <yunchuan@nfschina.com>, dzm91@hust.edu.cn,
        christophe.jaillet@wanadoo.fr, horms@kernel.org,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <169825592825.1275256.15739613451588018012.kvalo@kernel.org>
Date:   Wed, 25 Oct 2023 17:45:30 +0000 (UTC)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wu Yunchuan <yunchuan@nfschina.com> wrote:

> No need cast (void *) to (struct net_device *).
> 
> Signed-off-by: Wu Yunchuan <yunchuan@nfschina.com>

Patch applied to wireless-next.git, thanks.

1002f8171d96 wifi: ray_cs: Remove unnecessary (void*) conversions

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231020093432.214001-1-yunchuan@nfschina.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

