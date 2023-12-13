Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9E858114E9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 15:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442026AbjLMOmP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 09:42:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1441994AbjLMOmO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 09:42:14 -0500
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5AF6CE8
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 06:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=IpSlZ
        JOBqYtRAf1iYqqERWp2+ffyu5bZyKNvpw25YGI=; b=AA5qhaBTUca9zYo1bprbt
        z+/yqAZtB2w9a5sgu9HfPq0i8EMi5Q3u0llOq+xyjL4zX1g6kXm2uoqYSfAbaLqO
        oUC8PVSDDiUE1NMbYwmB/lFSww5e6PKIPIUzq8QLw/f2+aLxKfoOsfRvwMzeAdJq
        Dgr2kxQKfXoq3rv0XZLlPw=
Received: from ubuntu22.localdomain (unknown [117.176.219.50])
        by zwqz-smtp-mta-g2-0 (Coremail) with SMTP id _____wD3v1I7wnllKU5XFg--.27907S2;
        Wed, 13 Dec 2023 22:39:56 +0800 (CST)
From:   chenguanxi11234@163.com
To:     linus.walleij@linaro.org
Cc:     arnd@arndb.de, cgel.zte@gmail.com, chen.haonan2@zte.com.cn,
        gregkh@linuxfoundation.org, jgg@ziepe.ca, jiang.xuexin@zte.com.cn,
        jroedel@suse.de, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux@armlinux.org.uk,
        rmk+kernel@armlinux.org.uk, rppt@kernel.org, willy@infradead.org,
        yang.guang5@zte.com.cn
Subject: Re: [PATCH linux-next] ARM/dma-mapping: replace kzalloc() and vzalloc() with kvzalloc()
Date:   Wed, 13 Dec 2023 22:39:54 +0800
Message-Id: <20231213143954.2541-1-chenguanxi11234@163.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CACRpkdap4LUbMcKv_zi=25A-SZf0DJhXiyR1zn0PfuR+b=3NfA@mail.gmail.com>
References: <CACRpkdap4LUbMcKv_zi=25A-SZf0DJhXiyR1zn0PfuR+b=3NfA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3v1I7wnllKU5XFg--.27907S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
        VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUVDGOUUUUU
X-Originating-IP: [117.176.219.50]
X-CM-SenderInfo: xfkh0wxxdq5xirrsjki6rwjhhfrp/xtbBnhBF+letfGaKtwAAss
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>Looks good to me:
>Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>Please put this patch into Russell's patch tracker.

Hello, I would like to ask, do you mean to have 
me CC the patch email to Russell?I don't really 
understand what patch tracker means.Thank you.

