Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D820E7E5BB0
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 17:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbjKHQro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 11:47:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbjKHQrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 11:47:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D45001FD6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 08:47:40 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FB75C433C7;
        Wed,  8 Nov 2023 16:47:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699462060;
        bh=2YJ/6GS0bW+n/ACRUP2CWd9dxYR3V9iS4ICGfAuIvOE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RrWC5bCxfSN+g1j47gq7+CkyDhLTtMrljPY30x2qgCDgJr1Tn1LpksM/slKoKEm6x
         5DpVU/7/o1xkbJCMrfqdKyjT3GKJSN2Qh3eHvIlRSORc8OxJpgWN0ERns6MK4ewyXo
         4LfV97F6PSz5Fg8R7OEsqy92mNJqasFcBbA4Rd8Pfk94fVTwWdSQrJ/ehTPyhFmXbW
         SfubHLZkQBZoftON6dKHARDBpuOmCuvhwAwy8FRBLoHlhtQqwKZpf+HAGKbAOzg8AM
         LfVR+ML1fwR+DDVEKGs/IJNtkQntcXj2xS0xD6fXF/p2YIrXUCX50DUxraUxZkNuE9
         XyDi/uE/oBMEw==
Date:   Wed, 8 Nov 2023 08:47:39 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     <davem@davemloft.net>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>
Subject: Re: [PATCH net v2] page_pool: Add myself as page pool reviewer in
 MAINTAINERS
Message-ID: <20231108084739.59adead6@kernel.org>
In-Reply-To: <0098508e-59ab-5633-3725-86f1febc1480@huawei.com>
References: <20231107123825.61051-1-linyunsheng@huawei.com>
        <20231107094959.556ffe53@kernel.org>
        <0098508e-59ab-5633-3725-86f1febc1480@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 8 Nov 2023 11:31:45 +0800 Yunsheng Lin wrote:
> For 2, yes, maybe I should stick to the rule even if it is a simple
> patch and obivous format error.

Yes, maybe you should.
