Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 003A07912C7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:58:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243933AbjIDH6Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjIDH6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:58:23 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEDBCC4
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 00:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1693814251; bh=zEg7xvRWZ7LlPBjS5OaojIVHGLyTgg3nPAKBWXlmGT0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=HPXidvIZIdB24jDr2qwyrw+A/pxWmG9hR3s7/qt2PUO26FJDG34aU8sp7sHXWggaN
         epu7ITy/KZM4nArvSq8EuRDnAo1Slfu2il0/f243fMMJwYxPOBuyMWTfrWT53/sHmU
         fJOm9X8YrB+LO+wWZIlTDzKQSSzUQ03v5t2iQ4Ng=
Date:   Mon, 4 Sep 2023 09:57:31 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     syzbot <syzbot+0e04fda096b0ca4f4d6c@syzkaller.appspotmail.com>
Cc:     andriy.shevchenko@linux.intel.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] general protection fault in rfkill_register
Message-ID: <503f8bbb-2d76-4bc0-8c5e-528ff159133d@t-8ch.de>
References: <000000000000128dfc060483768b@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000128dfc060483768b@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz dup: general protection fault in netdev_register_kobject
