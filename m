Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E6377D781F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 00:40:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjJYWku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 18:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230212AbjJYWks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 18:40:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 464DE10A
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 15:40:46 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567F8C433C8;
        Wed, 25 Oct 2023 22:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698273645;
        bh=6VemVSnou01KIev5TWjqvg8zizi3ofcgyerPYhgHr3k=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=h7t0l+NYM9IqreesVzQsEZWlLb9rVcFrchZI1F9v00QzsfwJ3j74x92IBDuoeZK4/
         f85lzF0oov/A3jDZFU0aEL9g2hrECAv/n0wGNz6wgV/2FCaUKImE8nJm/LWNyNre0G
         QH+oAkbVkCSKjUs+QLhxwrg5HqNUcyFXcVQyHE0NXIA3yN1uiqadG0TFH4YhKql0N8
         Bh/e1pnefZDnboUWwgmlBgIA+oeAeyaBSRy8N/p4fGc/1R/ancZdySxTzwHByTptSl
         Di3qaYiKd9z8KQqZLg6k+T4bP2TgOTSAtdBFmEY7YXuHHT5XO0a///MXfhGVHb2J2n
         +rxHTjGKDN5IQ==
Date:   Wed, 25 Oct 2023 15:40:44 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     "Radu Pirea (OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc:     sd@queasysnail.net, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, andrew@lunn.ch, hkallweit1@gmail.com,
        linux@armlinux.org.uk, richardcochran@gmail.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        sebastian.tobuschat@oss.nxp.com
Subject: Re: [PATCH net-next v8 0/7] Add MACsec support for TJA11XX C45 PHYs
Message-ID: <20231025154044.7877e5c0@kernel.org>
In-Reply-To: <20231025151834.7e114208@kernel.org>
References: <20231023094327.565297-1-radu-nicolae.pirea@oss.nxp.com>
        <5d7021cd-71b1-4786-9beb-1a4fe084945c@oss.nxp.com>
        <20231025151834.7e114208@kernel.org>
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

On Wed, 25 Oct 2023 15:18:34 -0700 Jakub Kicinski wrote:
> On Wed, 25 Oct 2023 19:21:24 +0300 Radu Pirea (OSS) wrote:
> > The state of this patch series was set to "Changes Requested", but no 
> > change was requested in V8 and I addressed the changes requested in V7. 
> > Am I missing something or is it a mistake?  
> 
> Another series got silently discarded because of a conflict.
> This one IDK. Everything looks fine. So let me bring it back, sorry.

Ugh, I found out why. It has already been applied :|
