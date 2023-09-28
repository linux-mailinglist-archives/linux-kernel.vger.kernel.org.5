Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDEA17B16EE
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:13:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231546AbjI1JNm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:13:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231415AbjI1JNj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:13:39 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEC3CAC;
        Thu, 28 Sep 2023 02:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3rRdcryONVDrbkbXLQtowPnUVqAI1rKuIS2d94ALM+M=; b=NcAT/CDHxVOvjdgCnDo/5q0y6a
        LJjfyxDB5YAvdGT9/BBsLHAdEJ/mm3x7NUgr3WJI/eBClqfqCVU564koYaxb8qIiDx8Kh8aPuVt1e
        WEmRU7rx8XfphXvrbpDYVq61KozMybL1ZEDN0BBC6YpN/JiK0pW9UjDbuJXcUYUi78MyMKZAJUFAF
        HKbwmiCC+JQvSmOGlHBJl9XVN6fnUn/vNkEv1Doeb341vETetpT1eLmJV5DFWxt063OwFhYb3ERPW
        1P2YWe8VSb4pxOW5sHWR5G9YribUoR5LQxZ1S0w7+IRVmNoLSoXNvPoc4jFKnGjCuvwoTpZ+jWXq5
        ggMWOOWQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qln5T-002hqV-2J;
        Thu, 28 Sep 2023 09:13:35 +0000
Date:   Thu, 28 Sep 2023 02:13:35 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc:     Jonathan Corbet <corbet@lwn.net>, workflows@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: submitting-patches: encourage direct notifications
 to reviewers
Message-ID: <ZRVDv2fiFyW2S0z1@infradead.org>
References: <20230927-docs-cc-reviewer-v1-1-2af46ceb2d3c@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927-docs-cc-reviewer-v1-1-2af46ceb2d3c@weissschuh.net>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

NAK.

This does not scale.  Please read the mailinglist, that's the whole
point of having it.
