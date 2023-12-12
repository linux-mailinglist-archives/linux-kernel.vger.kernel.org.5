Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7794680E4E1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 08:33:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345926AbjLLHb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 02:31:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjLLHb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 02:31:58 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF1F8BE;
        Mon, 11 Dec 2023 23:32:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=rr54eCZeM9Bxbn46edNVm7xvL1Q/VdLAN/WkKi1Csu4=; b=yA4HlQ9itEHPME5W0PkZ9Kf+d0
        kxgVuiYZBICWhXv8zyC2Kg3XXnZ+Bi6ilNVY9ke1tW8EBGkzNEbUgbw9liY/qAOmQFQngXuxFAmH2
        jyFZTU3iquxKl8L+GmPCCBFdh72mcmfiW/ikK8kT+IsHu3Da+NF5wewcrukRQB9QtHLXyDklhNg5Q
        EYylBUjvzxK63/5LgH6sm4mDznTguYbxaRqayOnlMgmccsFDUFTUHn8eNCF1kIX/wzO3XwvRv+YWC
        siIKKLbdZa0Kp27DpDELKeWdiLaDMsj/Cu0A3PN1IjDM/z5UN15fDHJw9U9zC2vopVHIQ8UJ3t8wF
        U5UjAMBA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1rCxFD-00Aw9f-1Q;
        Tue, 12 Dec 2023 07:31:55 +0000
Date:   Mon, 11 Dec 2023 23:31:55 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Leonardo Bras <leobras@redhat.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [RFC PATCH v5 1/1] scripts: Introduce a default git.orderFile
Message-ID: <ZXgMa57Ere6FJCJB@infradead.org>
References: <20231208181802.88528-3-leobras@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231208181802.88528-3-leobras@redhat.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Urrg, hell no.  Alphabetic order is the only one allowing sensible
searching.  If you have a different preference use your local .gitconfig
instead of enforcing completely random preference on others.

