Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989BB80D21E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 17:38:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344897AbjLKQiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 11:38:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344890AbjLKQiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 11:38:20 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78067B3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 08:38:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=wpHThLvSQpgLnGqGFh5KYHIHAS9c2lvgN7/hY/KpQ5g=; b=xidMKSW3vrSvMtdcHyR5jyoj+n
        RFhP71NXa5EhonMjlMsb6uwYlqqUjeKrygUdmtV6MCK+EX6CJBbkCf9VWLbwj3Lx5m4kw6L3lNi4B
        wJ5tlPEdyai/nRBsmc7YgNwafiqE+QxbhFTv3/FJGYicBwY5kj+XUrzEmGdr1hwzpbz2+dFwYJCnG
        Si6llKIVx5CJP883ryDBr+JHkIBNrFTJse9UHxILuL9DotS3izflqim7cWE9N9DsdlnCOrWa4yJqN
        w4HhAeoxk5hoOoNS+4vEOtsf+Nyu0mqTw35B+5BkYkO/wYHrTCuohhiZfBXBEMQChZSxN0hjjQUDe
        lT9UGLRw==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rCjIZ-005tFL-0h;
        Mon, 11 Dec 2023 16:38:27 +0000
Date:   Mon, 11 Dec 2023 08:38:27 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/3] freevxfs: bmap: fix kernel-doc warnings
Message-ID: <ZXc7A6c1OXHEWlnJ@infradead.org>
References: <20231207212035.25345-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231207212035.25345-1-rdunlap@infradead.org>
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

All three patches looks good to me:

Reviewed-by: Christoph Hellwig <hch@lst.de>
