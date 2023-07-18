Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCE77583AC
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 19:42:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231680AbjGRRmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 13:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjGRRml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 13:42:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 356A610CB
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 10:42:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 54593616A7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 17:42:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 815F7C433C8;
        Tue, 18 Jul 2023 17:42:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689702159;
        bh=OVM9xBSWB0lSPAQfi3kP38TgLm25jCFmquqGbvbUqpQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PMqmTr1fr9B3xl6BvLreVfsrK78rkKMP/lrV1x5DCMuROkdvUGgUqFjm/9oXrDR2N
         ELAFNjhHpSmPKolgsZdmb9dIwBtfnIoqbZ3YMV4znbYBu8OHvO3RfRpCp3nk34aehn
         CBVjJbJ361i+UrhKeFoFBQ4Pl1/2Kzc8HQxIH9Gpz3HmLuaV6yunyCb/B2QQQAcde9
         Qo+JPgN0UoEvjF5D3mFV95Bs+RuA1rJKUobEPb0ks3z3X1qf09fz1cJHPtff65bexj
         rQjWrZY4J4mWqLz+S6aVH6/dlYlJgUijFrreSKLlur0VYNUJjIWpGfRfe8TbAcrVCC
         87rtNBc2tedgQ==
Date:   Tue, 18 Jul 2023 10:42:38 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     hanyu001@208suo.com
Cc:     davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 3c59x: Add space around '='
Message-ID: <20230718104238.5125d4bb@kernel.org>
In-Reply-To: <304ca645a55aa0affe830bd36edaf24d@208suo.com>
References: <tencent_7B6F5BD00E87F90524CC452645A9D0DB2007@qq.com>
        <304ca645a55aa0affe830bd36edaf24d@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jul 2023 11:27:10 +0800 hanyu001@208suo.com wrote:
> Fix checkpatch warnings:
> 
> ./drivers/net/ethernet/3com/3c59x.c:716: ERROR: spaces required around 
> that '=' (ctx:VxV)
> ./drivers/net/ethernet/3com/3c59x.c:717: ERROR: spaces required around 
> that '=' (ctx:VxV)
> ./drivers/net/ethernet/3com/3c59x.c:717: ERROR: spaces required around 
> that '=' (ctx:VxV)
> ./drivers/net/ethernet/3com/3c59x.c:717: ERROR: spaces required around 
> that '=' (ctx:VxV)
> ./drivers/net/ethernet/3com/3c59x.c:717: ERROR: spaces required around 
> that '=' (ctx:VxV)

Networking does not accept checkpatch-based coding style fixes as others
already pointed out. Plus your patches are broken (white space damaged),
and you sent 10 of them before waiting for any feedback, please stop.
-- 
pw-bot: reject
