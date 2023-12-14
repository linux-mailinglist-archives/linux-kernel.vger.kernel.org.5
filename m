Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE3D5812873
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 07:49:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443251AbjLNGs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 01:48:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjLNGs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 01:48:57 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D783AE8;
        Wed, 13 Dec 2023 22:49:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VwDqvg57fzCjHeJdXQ7BKuFaBbLUlDwICUOjyFt1o7I=; b=EVnZVPpIbtKeIVxC8cbCE7CybH
        N+cb0xIJOPkXPCIcA5H6+1skRis2ohr+DGrdC3+VNabal/xsWOulv3Uuzl4gDSgf+tAWYCX7K8m5C
        +V2v4pp1sdxOhqm21zGTSXPi1RIaWc7XphvBq9SnftALgj80W2gVbdtk2ZI7icT6oa3CtUwvXwC8z
        IjXmUVnVhZeRina4K/EqAFaXLXXoQmyTxQ6XjrpUDbeSi+dSdLV0qJUUv1RaRqfERvQR50KD5HHD+
        M2fWRD2dfxjSJnmpmvRjDY5FBQ7UnQIsv/6fm48fZ+iIyp3VYKZlumWz9ndHkbCqOun8e92nBmZoV
        ATVH3uPQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rDfWj-00H1dE-0o;
        Thu, 14 Dec 2023 06:48:57 +0000
Date:   Wed, 13 Dec 2023 22:48:57 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     patchwork-bot+netdevbpf@kernel.org
Cc:     Mina Almasry <almasrymina@google.com>, shailend@google.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-kselftest@vger.kernel.org, bpf@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, corbet@lwn.net, jeroendb@google.com,
        pkaligineedi@google.com, hawk@kernel.org,
        ilias.apalodimas@linaro.org, arnd@arndb.de, dsahern@kernel.org,
        willemdebruijn.kernel@gmail.com, shuah@kernel.org,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        linyunsheng@huawei.com, hramamurthy@google.com, shakeelb@google.com
Subject: Re: [net-next v1 00/16] Device Memory TCP
Message-ID: <ZXqlWT2JYg0sa7IF@infradead.org>
References: <20231208005250.2910004-1-almasrymina@google.com>
 <170253482786.28524.10625748175644260187.git-patchwork-notify@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170253482786.28524.10625748175644260187.git-patchwork-notify@kernel.org>
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

On Thu, Dec 14, 2023 at 06:20:27AM +0000, patchwork-bot+netdevbpf@kernel.org wrote:
> Hello:
> 
> This series was applied to netdev/net-next.git (main)
> by Jakub Kicinski <kuba@kernel.org>:

Umm, this is still very broken in intraction with other subsystems.
Please don't push ahead so quickly.

