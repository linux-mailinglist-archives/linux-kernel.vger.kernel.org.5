Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8450D80BDBF
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 23:59:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232169AbjLJWz6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 17:55:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjLJWz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 17:55:56 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40F66E8
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 14:56:03 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 809AFC433C8;
        Sun, 10 Dec 2023 22:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1702248962;
        bh=f747EOaaeU8qo4brPxPpAkTzmHDynn7BfgSl6koLvC0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=P1wPPfg8N9pXQtg/2sa6nPLmWxb4fXJOc9gIKxqadjk4fKQ/UT3cNxTdUi+TGklwU
         r/IXowCiFEQCATs0OrBq4eF2HVXto0ax60LerqUxgs0ihgi66kWvhQT1D4Rrm8ahJP
         ekEK6K63KQVsGEP2VH/f7fvNh2yaAdmn4nX5CSak=
Date:   Sun, 10 Dec 2023 14:56:01 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH] maple_tree: fix typos/spellos etc.
Message-Id: <20231210145601.177b543ca2ed28b9551575ff@linux-foundation.org>
In-Reply-To: <ZXYp60O0qxvPmuHu@casper.infradead.org>
References: <20231210063839.29967-1-rdunlap@infradead.org>
        <ZXYp60O0qxvPmuHu@casper.infradead.org>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 10 Dec 2023 21:13:15 +0000 Matthew Wilcox <willy@infradead.org> wrote:

> On Sat, Dec 09, 2023 at 10:38:39PM -0800, Randy Dunlap wrote:
> > - * mas_topiary_node() - Dispose of a singe node
> > + * mas_topiary_node() - Dispose of a single node
> 
> That's all well and good, but how do we dispose of singed nodes now?

Lol, this is my all-time favorite typo!


hp2:/usr/src/mm> git log | grep Singed-off-by | wc -l
59

(sounds painful)

hp2:/usr/src/linux-6.7-rc4> grep -ri singe .

