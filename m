Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B927D77B2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 00:18:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjJYWSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 18:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjJYWSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 18:18:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C99183
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 15:18:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62861C433C8;
        Wed, 25 Oct 2023 22:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698272315;
        bh=7wceXJu0kfijNOlBso72VednjzjibjvHan7ExujoI/w=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=DWmVxAWREBOhru7p4LdfDFUEzEY6ZYaeaV757ksoVIEBozJ+Kv1pg8R+b1CwIlnux
         jaLSj+BcoG5IN4SeI0Yj/YrIjgFAD6I/XkPirB2C98pNbPcGD3yQHmGNDgxEp/iRuJ
         3TKCiJeAf8hwCPlNLrhZ2rXSc4LzaFFlqRzIjTpalm8V2YbjNFGBQV0wK0BNaqiNZU
         XOy9gnDK7HGyUDDyCYELCOT9/Ie3shC8KjdVwSaXyJGvW+mHkqFO4R8Rnbwl+g6eds
         /iuUbmRTNosvWBL1FjQpWBwKRb7OBrnebv7zl08/Eyu/wpM3CDhnPuz6QW+sEneCxq
         6IrG4B45UCHyA==
Date:   Wed, 25 Oct 2023 15:18:34 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     "Radu Pirea (OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc:     sd@queasysnail.net, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, andrew@lunn.ch, hkallweit1@gmail.com,
        linux@armlinux.org.uk, richardcochran@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        sebastian.tobuschat@oss.nxp.com
Subject: Re: [PATCH net-next v8 0/7] Add MACsec support for TJA11XX C45 PHYs
Message-ID: <20231025151834.7e114208@kernel.org>
In-Reply-To: <5d7021cd-71b1-4786-9beb-1a4fe084945c@oss.nxp.com>
References: <20231023094327.565297-1-radu-nicolae.pirea@oss.nxp.com>
        <5d7021cd-71b1-4786-9beb-1a4fe084945c@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Oct 2023 19:21:24 +0300 Radu Pirea (OSS) wrote:
> The state of this patch series was set to "Changes Requested", but no 
> change was requested in V8 and I addressed the changes requested in V7. 
> Am I missing something or is it a mistake?

Another series got silently discarded because of a conflict.
This one IDK. Everything looks fine. So let me bring it back, sorry.
-- 
pw-bot: under-review
