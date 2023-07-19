Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 864E4759862
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 16:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbjGSOcF convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 19 Jul 2023 10:32:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbjGSOcE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 10:32:04 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA81D1A6
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 07:31:58 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 5D1B1634202F;
        Wed, 19 Jul 2023 16:31:56 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id zaKynDZcz5vf; Wed, 19 Jul 2023 16:31:55 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id D49FC6342049;
        Wed, 19 Jul 2023 16:31:55 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jP2E1FoDpgBZ; Wed, 19 Jul 2023 16:31:55 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id AFEA5634202B;
        Wed, 19 Jul 2023 16:31:55 +0200 (CEST)
Date:   Wed, 19 Jul 2023 16:31:55 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Stephan Wurm <stephan.wurm@a-eberle.de>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Johannes Eigner <johannes.eigner@a-eberle.de>
Message-ID: <1006337471.13025.1689777115644.JavaMail.zimbra@nod.at>
In-Reply-To: <ZLVWfrlEOWT1twpr@PC-LX-Wurm>
References: <ZLT2qEYjaWgSpRD6@PC-LX-Wurm> <736980270.3262.1689586950735.JavaMail.zimbra@nod.at> <ZLUXruUkYMrPK+GQ@PC-LX-Wurm> <260741266.3681.1689591789332.JavaMail.zimbra@nod.at> <ZLVWfrlEOWT1twpr@PC-LX-Wurm>
Subject: Re: ubiblock: null pointer dereference using scatterlist in
 work_queue
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: ubiblock: null pointer dereference using scatterlist in work_queue
Thread-Index: QWBZmEM+jrW3AoQV9zucPkJZxr7Mdw==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Stephan Wurm" <stephan.wurm@a-eberle.de>
>> > We did not check other stacked devices, but we'll give this a try.

Did you find the time to check with dmcrypt?
Just to give me a hint where to start looking.
I'm still a little puzzled what is going on here.

Thanks,
//richard
