Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5D57B3E9C
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 08:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbjI3GOD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 02:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjI3GOB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 02:14:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC2561AB;
        Fri, 29 Sep 2023 23:13:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D64FDC433C7;
        Sat, 30 Sep 2023 06:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696054439;
        bh=4a0tblP3n3uiYoGh+jE1PItEJ/6scR1bU+57t6WA/Tw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GoZG9Ek04SuxXMOWz5g1jo6otBnQ6yg156MfkMYh/W71zFTiCWDMA1D8LyzpOcw0l
         p4MBD9ef1ZcVsI/nT38Am1LOaDw8Iq1vSKdKZAOePkw5s9tYmpzxYYMZSCqbm8NujO
         6zpk3+MHuetHecsJqPSrXYl4EdUfDdqn4K7RQr+k=
Date:   Sat, 30 Sep 2023 08:13:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Edward AD <twuufnxlz@gmail.com>
Cc:     alex@ghiti.fr, alexghiti@rivosinc.com, aou@eecs.berkeley.edu,
        conor@kernel.org, guoren@kernel.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-serial@vger.kernel.org, liushixin2@huawei.com,
        palmer@dabbelt.com, paul.walmsley@sifive.com,
        syzbot+8d2757d62d403b2d9275@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] Test for riscv fixes
Message-ID: <2023093049-next-confusion-b812@gregkh>
References: <2023092939-lagoon-punctual-e312@gregkh>
 <20230929230534.45142-2-twuufnxlz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230929230534.45142-2-twuufnxlz@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 30, 2023 at 07:05:35AM +0800, Edward AD wrote:
> On Fri, 29 Sep 2023 08:04:57 +0200 Greg KH wrote:
> > Where are you getting your odd cc: list from?  This has nothing to do
> > with serial drivers...
> https://lore.kernel.org/all/0000000000000170df0605ccf91a@google.com/raw

I do not understand this answer.
