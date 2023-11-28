Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB817FC2CB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346378AbjK1PBw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 10:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345972AbjK1PBt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 10:01:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61A4A182
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 07:01:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C08DAC433C7;
        Tue, 28 Nov 2023 15:01:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701183716;
        bh=sMnYOB8L1SwL3ciBBDXLq1lHVhS0WDYNcQcKrKXu7aA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UXIl3mQawuOK0Pj6zNfnpMrySaZuaqJGQZ38y9k6+GhkQmQviqw/QHHE7yzWbLuPB
         FRbkikDZyhwBnoon5LVJ8Dr8Uw7vQiR1NfcTiaANyKJ6r5VS5OTStjhGl2w3WW13iT
         ReaGqaeYAJXbULeT4H5VbQsxVaNZyJoOVV/GgpOAWuZ3duUcfovQdjGk996Cw+0LKh
         OS8GSynk21d2f5/0bq6EZPOeR/1iYfePdCKdidKraDopPc6+NLA44KrAm682aV9DLu
         85u1uMkKZGCkj8sn3DaupkBR8CQj0su0qpkCE633KfxpNuiIqZnDtRMA7wIxNpK2zR
         nQSZTrWwhZsyg==
Date:   Tue, 28 Nov 2023 07:01:54 -0800
From:   Jakub Kicinski <kuba@kernel.org>
To:     Aleksandr Nogikh <nogikh@google.com>
Cc:     syzbot <syzbot+listaba4d9d9775b9482e752@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] Monthly net report (Nov 2023)
Message-ID: <20231128070154.2beee02c@kernel.org>
In-Reply-To: <CANp29Y77rtNrUgQA9HKcB3=bt8FrhbqUSnbZJi3_OGmTpSda6A@mail.gmail.com>
References: <00000000000029fce7060ad196ad@google.com>
        <20231124182844.3d304412@kernel.org>
        <CANp29Y77rtNrUgQA9HKcB3=bt8FrhbqUSnbZJi3_OGmTpSda6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Nov 2023 15:54:00 +0100 Aleksandr Nogikh wrote:
> Maybe it could be worth it to add "X: net/9p/" to "NETWORKING [GENERAL]"?
> Syzbot would then eventually also pick up the change.

Good point, sent.
