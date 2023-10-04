Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 062BA7B8EB1
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Oct 2023 23:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233811AbjJDVVU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 Oct 2023 17:21:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbjJDVVT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Oct 2023 17:21:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A3CBF
        for <linux-kernel@vger.kernel.org>; Wed,  4 Oct 2023 14:21:15 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441B6C433C7;
        Wed,  4 Oct 2023 21:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696454474;
        bh=+mnPw2cgov2C697kC7dBfIcSrWXIS18s9CkSLWTJFzY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=g4Dz0nCiTVV25EjY4hEX57MOTtJjWHhUrSuqFmQil9U+FS5Zm7uOkasKgh17Tz/vY
         2KQrMNIAGP0wDYXYNulB8TDNA2HqA5ouSTJbmoXBLZc2ogeFG0ITgzj998iXNbbMEX
         +Ai/iOQNBwfUxTvSPMicE/9u8WS2rd6zkfmSvp2Amq6dtrL4hNIUj4tYXUd7jD9GEp
         1NeZpQbpWzNHeQCLwfc7Tw0fel1sz2hw021b/LjruBBLwmjIpTsW1DQoZzBZT2HrDk
         t51qVgTldNS4OrMbJV/iOv2+qqEbdqr6vJfBIuvBr1Tr2iVJtcmTGWEu1JVj1UmjAk
         PeHDDmbPz1fYw==
Date:   Wed, 4 Oct 2023 14:21:13 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Simon Horman <horms@kernel.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org
Subject: Re: [PATCH] net: skbuff: fix kernel-doc typos
Message-ID: <20231004142113.71b19c16@kernel.org>
In-Reply-To: <ZRvwn8lTaFxJ83X/@kernel.org>
References: <20231001003846.29541-1-rdunlap@infradead.org>
        <20231001003846.29541-2-rdunlap@infradead.org>
        <ZRvwn8lTaFxJ83X/@kernel.org>
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

On Tue, 3 Oct 2023 12:44:47 +0200 Simon Horman wrote:
> > - * so we also check that this didnt happen.
> > + * so we also check that this didn't happen.  
> 
> At the risk of bikeshedding (let's not) perhaps "this" can be dropped
> from the line above?

+1, since we're touching the line we can as well..
