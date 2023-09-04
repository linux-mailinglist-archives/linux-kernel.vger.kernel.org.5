Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D42A7912B8
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346896AbjIDH4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238322AbjIDH4u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:56:50 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B5E013D
        for <linux-kernel@vger.kernel.org>; Mon,  4 Sep 2023 00:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1693814194; bh=zEg7xvRWZ7LlPBjS5OaojIVHGLyTgg3nPAKBWXlmGT0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=d1Ky/pPOj04wkmiNMG1mjpGr5duV526GCjuqhcyS+JB0bomWxgmpwr66B/p7hXF71
         DnKpqC5N7OywG71dmtbArXIsa34KErq3SIqEpWe+WSzxobDmq6lt8Nx6jBoUzDEA6o
         +MpThaGh2wf3nF7Zr9v6rmMrkFYF1mvfrJU9qyEA=
Date:   Mon, 4 Sep 2023 09:56:33 +0200
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     syzbot <syzbot+f31b0633f7ca73e2d726@syzkaller.appspotmail.com>
Cc:     andriy.shevchenko@linux.intel.com, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org, rafael@kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [kernel?] general protection fault in evdev_connect
Message-ID: <1a479407-b0a7-4c6e-9af1-610bdf3787fc@t-8ch.de>
References: <000000000000196cf906048376d5@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000000000000196cf906048376d5@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

#syz dup: general protection fault in netdev_register_kobject
