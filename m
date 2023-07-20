Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C0D75A5F2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 08:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229561AbjGTGAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 02:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjGTGA2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 02:00:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C1E892
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 23:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NmHDzd6+Qpj1JCN9oL8/X61wR9W69WzHBrp2p+7Od+M=; b=g2B0VhMaIFM+EqFvUFtfojfQ1p
        L5qAK2qS2uIaOXJqPNyIec7PeZ+r5b9EZ4IzbowrtOBXnGDrFAgxO0eUQZjkreHf/69B73uLa02TX
        J6AdKQYUQ4YpKVvJThQdNfWufJGEdQo9AFKyI9COOOTaSyFx82PQmRULkHVsIUUnYTlW28bIy0g+G
        74sLYOjxEff7pgK2tkYRRyQn68rCPDXsTJMo0JHQ6Y9Bda6kHrQsQ/5qA8o3t9flPZFCjUu18rX4v
        uyO2cOJ78ScfzRS8H7IwVToXFBCdKoT1se0s9IoMtLe6CV86q8bUW7zaPZ6j1lLUOTod91xi97cFY
        qcF7urcw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qMMi0-009sXO-20;
        Thu, 20 Jul 2023 06:00:16 +0000
Date:   Wed, 19 Jul 2023 23:00:16 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        Christoph Hellwig <hch@infradead.org>,
        Nhat Pham <nphamcs@gmail.com>,
        Domenico Cerasuolo <cerasuolodomenico@gmail.com>,
        konrad.wilk@oracle.com, vitaly.wool@konsulko.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm: kill frontswap
Message-ID: <ZLjNcPp/jHch5fKt@infradead.org>
References: <20230714194610.828210-1-hannes@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230714194610.828210-1-hannes@cmpxchg.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks!

Acked-by: Christoph Hellwig <hch@lst.de>
