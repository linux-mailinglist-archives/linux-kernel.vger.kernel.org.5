Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20427801A62
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Dec 2023 05:06:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbjLBEFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 23:05:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjLBEFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 23:05:09 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4317B126
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 20:05:16 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66FA8C433C9;
        Sat,  2 Dec 2023 04:05:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701489915;
        bh=uxQmETHLPfyNkyGcnpM4hPLPgPAseia2ALvVF4tnZmo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WnVUOagaPsS9/3e9u6mSYKFsxVn3H3/NnhE6AFcnTzFeUsEB5H37QKUf8GCBnFcLe
         4EgXs1vmtdxMbL+O0I814nF2Kibhr5OAifSx5q6kWt1PSjIhngN8SlgFMTS6CqFSWu
         5gYv6/nRH2rAEEy/6cgT3DOUG4JOuR+AtFsNhV0ceBo+Pc6mGgDr6FW82rUCOalRHl
         lVwpXARQ0pdQcIboo7fG5IHRvgvOezgvK8UfovLx7lX0AG4yQWx+x2ns5FZV4y++gE
         ofznDi8fMgLDR7XdaeXXlrZ/tiPIc1jyOPX14+y2ioMQOu51hevJRMaVHUMPjKKeCT
         vtA0QLW0uQO/w==
Date:   Fri, 1 Dec 2023 20:05:14 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Thomas Reichinger <thomas.reichinger@sohard.de>
Cc:     Michael Grzeschik <m.grzeschik@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arcnet: restoring support for multiple Sohard Arcnet
 cards
Message-ID: <20231201200514.1b0b55a1@kernel.org>
In-Reply-To: <20231130113503.6812-1-thomas.reichinger@sohard.de>
References: <20231130113503.6812-1-thomas.reichinger@sohard.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2023 12:35:03 +0100 Thomas Reichinger wrote:
> commit 5ef216c1f848 ("arcnet: com20020-pci: add rotary index support")

Fixes: 5ef216c1f848 ("arcnet: com20020-pci: add rotary index support")

right?
