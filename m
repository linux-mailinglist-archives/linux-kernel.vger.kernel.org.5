Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A12777E25A4
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 14:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232810AbjKFNeC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 6 Nov 2023 08:34:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232824AbjKFNdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 08:33:49 -0500
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B2CBD49
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 05:33:42 -0800 (PST)
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-3b5665e00b6so6717249b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Nov 2023 05:33:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699277622; x=1699882422;
        h=content-transfer-encoding:cc:to:from:subject:message-id:in-reply-to
         :date:mime-version:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TeB2he2++u6/LQSKGnkURNk3ibn1OC35DdeJmyuq0Gg=;
        b=FE7xy0QQ/bQ5AfxfjeEtSI6PSjXBzUPcG3ejncUf6TnjOVqeBXUXBW1NL7l+RFe3yw
         uDoyq202Yl5jrwR5Z1znCslTYC0f0eqMS30YjmPLr5eCTWs0moxmO4nSeSnHQLsd4toJ
         s2/FC0lnSC7B9UmiAdPKt5I4WdYduPEzsQpPu6RTALmX+u9Bwa2bvKVH9cmSV24350iJ
         Bd9+FBthO4tC3UpfzEjtRgUolbI+A/Kep71RuqoYflUkX8xM7lSPjGzBMvr0x8Beppdy
         yQbpgbb9LDmb/Y5VxE7Bn5IppoRR8kqxeipWqGajFCMteM7414dGUSvVERzsBR7yrZRz
         si0Q==
X-Gm-Message-State: AOJu0Yx38FtpZHFr4kp4J1VmUpGgNnMQHxkkycT3AsisoMSZsiMsntn0
        b0+YwWkb/nt+1zJaxuHnjT7X1da4NFdG1OXy9VXGtnG2D/zI
X-Google-Smtp-Source: AGHT+IHgCklWkqU5nllIlMXZZUGevclghkZxM9r23MdhU4sX/nDqwasNbiHU2lsjamfV+tTdOWKZrnpmBIfrTiSaUohH1DW7XKmz
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1304:b0:3ae:15b6:3292 with SMTP id
 y4-20020a056808130400b003ae15b63292mr11279293oiv.4.1699277622025; Mon, 06 Nov
 2023 05:33:42 -0800 (PST)
Date:   Mon, 06 Nov 2023 05:33:41 -0800
In-Reply-To: <DB3PR10MB6835B7FED9E7D84ED8DF7400E8AAA@DB3PR10MB6835.EURPRD10.PROD.OUTLOOK.COM>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000922f806097be773@google.com>
Subject: Re: Test
From:   syzbot <syzbot+84f695756ed0c4bb3aba@syzkaller.appspotmail.com>
To:     yuran.pereira@hotmail.com
Cc:     yuran.pereira@hotmail.com, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> #syz test:�https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

unknown command "test:\xa0https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git"

