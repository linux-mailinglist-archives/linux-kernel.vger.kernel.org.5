Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A15E376B2CF
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 13:13:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232137AbjHALNZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 07:13:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232394AbjHALMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 07:12:34 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219EB2686
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 04:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=xQ7qpM74rvVAxh/R7yF1VX16lTCqWk7Q9ekIOoTYz8o=; b=fT7zK16RX8OetHir6wcM2THFzQ
        JowHgR6pE95MipWheHvhDGdVynfNp+6ic1O9QMekUm0yeubKRhD9XN0E9vbnigrySR2nKufCJVuVQ
        6pob316TTJRlUwHirXxrcV6wB/jwjfE5rur5kmekDY90RBYn2QrnCPbtqpJiy4VEBucpTVPCiSNqf
        70o+6h9NkIEojMZoI4BHyNquwphaxl1T6xezC1EpV5j6DcII5eoWtDY4IiD2P/HpzwaRhMLzLw6YG
        x4qUhgdGIioGpCP+YGRsxbQYvzIKoDFiddNtmn4oA4Ab8T5bEVjiVn0FzXYLdADjuYtmQZGhhDSs/
        /PngbnWQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qQnET-0023Xo-2x;
        Tue, 01 Aug 2023 11:08:05 +0000
Date:   Tue, 1 Aug 2023 04:08:05 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, Baoquan He <bhe@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iomem: remove __weak ioremap_cache helper
Message-ID: <ZMjnlTZUXYCXRc/Y@infradead.org>
References: <20230726145432.1617809-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230726145432.1617809-1-arnd@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ah, nice:

Reviewed-by: Christoph Hellwig <hch@lst.de>

