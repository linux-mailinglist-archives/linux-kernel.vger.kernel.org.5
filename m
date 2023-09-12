Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C132479CD28
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 12:06:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233943AbjILKGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 06:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233892AbjILKGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 06:06:35 -0400
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E103919BF;
        Tue, 12 Sep 2023 03:05:58 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qg0H4-00DIYF-N6; Tue, 12 Sep 2023 18:05:39 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Tue, 12 Sep 2023 18:05:41 +0800
Date:   Tue, 12 Sep 2023 18:05:41 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Longfang Liu <liulongfang@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        Zaibo Xu <xuzaibo@huawei.com>, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-crypto@vger.kernel.org
Subject: Re: [PATCH] crypto: hisilicon/hpre - Fix a erroneous check after
 snprintf()
Message-ID: <ZQA39QVl/Py/m7A4@gondor.apana.org.au>
References: <73534cb1713f58228d54ea53a8a137f4ef939bad.1693858632.git.christophe.jaillet@wanadoo.fr>
 <ZPaSCOX1F9b36rxV@gondor.apana.org.au>
 <00bdcfec-6cc1-e521-ceaa-d16d6341ca16@wanadoo.fr>
 <909a0cff-ed2c-4728-81ee-57a5d786f450@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <909a0cff-ed2c-4728-81ee-57a5d786f450@moroto.mountain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 09:39:18AM +0300, Dan Carpenter wrote:
> 
> No debugfs files are left.  There is a remove recursive in
> hpre_debugfs_init().

Good catch.  I'll move the patch back onto the queue.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
