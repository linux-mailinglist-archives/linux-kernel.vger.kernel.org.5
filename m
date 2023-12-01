Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E4E80092B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 11:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378418AbjLAK5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 05:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378359AbjLAK5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 05:57:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA2493
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 02:57:44 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B76DC433C9;
        Fri,  1 Dec 2023 10:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701428263;
        bh=nC5xwZOy6zOgP7UJLi8bxNzdziURwOB3M+M55ko464o=;
        h=From:To:In-Reply-To:References:Subject:Date:From;
        b=qZ74a4JSdFhYHbnXUY9rvXzrtMS2ND/zW4h6kY+mHE46AopMYHwgzOZf0cX2JnF6t
         Ybil6aBlofhZlgagSad96RcZu0nib6g9u9IaXK6RA4n+tAdsj282XvAPX40nvHW97O
         zhAVbOQu9Ddzup6vb6OTOHx8G7kmk8G0NZXyHdXUgRZPQdH10I/leSuud8rT3WYPju
         +DQDsIc87vDRGsmThhH2Db7+DCwXD3k2MD8xFGxoBAtx6G8/yoeOQjpVj+sNBKFjv7
         StfbjcC6tF4U7mkZyH6ASkeZW3st7twPjnbNVzxanO9DezUvGeZc6GjV6fmQkFK12O
         pDzGEH6ITKObg==
From:   Lee Jones <lee@kernel.org>
To:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Andrew Lunn <andrew@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
        =?utf-8?q?Marek_Beh=C3=BAn?= <kabel@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Li Zetao <lizetao1@huawei.com>, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org, Daniel Golle <daniel@makrotopia.org>
In-Reply-To: <99e7d3304c6bba7f4863a4a80764a869855f2085.1701143925.git.daniel@makrotopia.org>
References: <99e7d3304c6bba7f4863a4a80764a869855f2085.1701143925.git.daniel@makrotopia.org>
Subject: Re: [PATCH v3 1/2] leds: trigger: netdev: extend speeds up to 10G
Message-Id: <170142826116.3357002.9561246405642038358.b4-ty@kernel.org>
Date:   Fri, 01 Dec 2023 10:57:41 +0000
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2023 04:00:10 +0000, Daniel Golle wrote:
> Add 2.5G, 5G and 10G as available speeds to the netdev LED trigger.
> 
> 

Applied, thanks!

[1/2] leds: trigger: netdev: extend speeds up to 10G
      commit: bc8e1da69a68d9871773b657d18400a7941cbdef
[2/2] docs: ABI: sysfs-class-led-trigger-netdev: add new modes and entry
      commit: f07894d3b384344c43be1bcf61ef8e2fded0efe5

--
Lee Jones [李琼斯]

