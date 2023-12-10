Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64D180BD4F
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Dec 2023 22:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232112AbjLJVNR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Dec 2023 16:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231837AbjLJVNP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Dec 2023 16:13:15 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60116E9
        for <linux-kernel@vger.kernel.org>; Sun, 10 Dec 2023 13:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zCPOcs3l7Il6DsY3daqFsLo02rrA9Nzvp+ulwvo3XUo=; b=mIx7CiBfhHxW5KTkxtow24uNBV
        xx08nehEqqQLi437W1wM5B+pLB18BDhV82r4oGB8ecgWvZAcesh5y4P39ZHBV3Gie8qEER/ZAH3z8
        d6bIRqtDrN5KNvwn/BK4UVlIGk7yoFQXhgFrAG0ovVxD92Q3N75dd2siJiYJMAgc93AkrPFm6YBjj
        FGk6EeRKawRaRhQ4K5zUqmpd2NZoYsSPWL9weKcQgraGv5s+ROXZWpOBgXzW/ZH8dcVcY8Rlkg3NX
        b7YGl675CeUylKGhaebIuq/P5LTW8Kwmnv5zO+jgMoKmyE5rav1MFpIr1H1WpI9AFkiAm4IWOAhGa
        8mGRd/6Q==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1rCR6x-008Hpm-NX; Sun, 10 Dec 2023 21:13:15 +0000
Date:   Sun, 10 Dec 2023 21:13:15 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        maple-tree@lists.infradead.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] maple_tree: fix typos/spellos etc.
Message-ID: <ZXYp60O0qxvPmuHu@casper.infradead.org>
References: <20231210063839.29967-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231210063839.29967-1-rdunlap@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 09, 2023 at 10:38:39PM -0800, Randy Dunlap wrote:
> - * mas_topiary_node() - Dispose of a singe node
> + * mas_topiary_node() - Dispose of a single node

That's all well and good, but how do we dispose of singed nodes now?

Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
