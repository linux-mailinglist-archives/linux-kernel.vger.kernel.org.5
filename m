Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42777B683A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:44:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240634AbjJCLo4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240523AbjJCLoy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:44:54 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34572C4;
        Tue,  3 Oct 2023 04:44:44 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5C06C433C8;
        Tue,  3 Oct 2023 11:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696333483;
        bh=g1cMEDzygz3CrEdKHgqMPmc+fXebxasdJMmGyr9hBA0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nHZcb7O7dtzjquNOOAfo1HhpwBZUCFsnU22i2w8X92NaY0avXhwKyoxciiPBcSMAX
         pg69zpA4q+WuxkzKnnfsbTKntYPBIg3hZAom8vrszHxaOQC+RvPc9VRPKo/LohDX1C
         XIQeCP+EaY4Z93qYiwPtDNpKEhj7g9S4YC7TFhoosAj6ir9dOTWU7IrZvLp5GgLKSb
         hpDNaN8pbqs8BJAB+5JI3AWD/TmO7d5LAODEfxWYyzkhS1khJ/+yx2zQ0hoTDAiD10
         bbgZNFuHMrBtmght3WRfjRYmY/5FHskKFN7sVfTXdpxGSOEgdBncjX3AqCNUFc0yCy
         vmBZS60oBlHhA==
Date:   Tue, 3 Oct 2023 13:44:39 +0200
From:   Simon Horman <horms@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH 2/3] wifi: mac80211: fix header kernel-doc typos
Message-ID: <ZRv+p69B4JbSETgJ@kernel.org>
References: <20231001191633.19090-1-rdunlap@infradead.org>
 <20231001191633.19090-2-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231001191633.19090-2-rdunlap@infradead.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2023 at 12:16:32PM -0700, Randy Dunlap wrote:
> Correct typos and fix run-on sentences.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Reviewed-by: Simon Horman <horms@kernel.org>

