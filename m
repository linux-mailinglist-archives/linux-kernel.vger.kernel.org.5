Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 773DB7B5517
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 16:32:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237677AbjJBOPI convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 2 Oct 2023 10:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237673AbjJBOPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:15:07 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6C2B7
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 07:15:02 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 81F156340DEF;
        Mon,  2 Oct 2023 16:15:01 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id RNrDw-EqjTxU; Mon,  2 Oct 2023 16:15:01 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 2FB386340DF3;
        Mon,  2 Oct 2023 16:15:01 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id iti3kq3l0Lc0; Mon,  2 Oct 2023 16:15:01 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 0ABAE6340DEF;
        Mon,  2 Oct 2023 16:15:01 +0200 (CEST)
Date:   Mon, 2 Oct 2023 16:15:00 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Lee Jones <lee@kernel.org>
Cc:     chengzhihao1 <chengzhihao1@huawei.com>, Yu Hao <yhao016@ucr.edu>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <918629851.25781.1696256100853.JavaMail.zimbra@nod.at>
In-Reply-To: <20231002140437.GA8453@google.com>
References: <CA+UBctD_w=75wChmePZHp7KsBSNPWYGDBtzHPRPPtaFoqhGvXA@mail.gmail.com> <412779912.228444.1682023015809.JavaMail.zimbra@nod.at> <ed510d18-47f1-7f46-03dd-84e043cab6d9@huawei.com> <1366603418.245114.1682236940160.JavaMail.zimbra@nod.at> <951e4cf7-a0ea-b3ec-931d-e6a394ddc2ab@huawei.com> <20231002101117.GA175828@google.com> <43988304.25483.1696242486225.JavaMail.zimbra@nod.at> <20231002140437.GA8453@google.com>
Subject: Re: BUG: divide error in ubi_attach_mtd_dev
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: divide error in ubi_attach_mtd_dev
Thread-Index: so9tCiFxUShqxZrF607c9ZOlLvgfjA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Lee Jones" <lee@kernel.org>
> Excellent, thanks.
> 
> I'd like to track it.  What's the subject please?

"ubi: Refuse attaching if mtd's erasesize is 0"
 
Thanks,
//richard
