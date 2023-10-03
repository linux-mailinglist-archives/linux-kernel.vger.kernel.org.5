Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEA407B5EE7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 04:03:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238975AbjJCCDB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 22:03:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjJCCDA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 22:03:00 -0400
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01B30C4
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 19:02:57 -0700 (PDT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3ae5ee6624dso587856b6e.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 19:02:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696298577; x=1696903377;
        h=cc:to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pPEFo8oXbjF8ymg516CdpgBbWirZ9N1y8MVaoi0LUdU=;
        b=ZzUxLUTozlvAEoJYweZftSFVTJUxraW4fP1TBj/0/9XNX0/B5MoJmnIQDoGAHhfv9K
         tK53exNbjhyCNU9fo/kuz1yTVjnr77jq+3u2xRM9KtHRsNCBfT3z5sBd8TQkmQiFemC8
         AgWUHBX/81ZW2oj0FlOJaKAocB63H7Si2PfAHgALSvwvqnk27WftE7g7t00CU4Oira1C
         5zIH+GNt/o9Y0C0nCZnDud16RYH89gVtCJUymU8b5lL4HCbpLIjQqWj/ZS7RnYlhndRb
         JXdS1blCigDvgKeYejAfOhsgOW0Agk28lb48lj5pTnI/T5SjbVSzitu8aN+iRAjEBRa8
         mJWA==
X-Gm-Message-State: AOJu0YzJJjKqTVpAtgc5qgye19TDO8zmhROPEw+PuIb1oVjYHzh0DCFP
        QDpniVV+HOyBUztO2S0JwDUmc9slRzzRU6ziZKJWByusAG4P
X-Google-Smtp-Source: AGHT+IFG6Y4BuEnzsU58NXttRueTKaCyi5cseJlO00Gj2Jgb/3OO8UWPOedLc16gZm2SspFlnfK80Ycu0WqzbDW/rzvRuj1J0uTP
MIME-Version: 1.0
X-Received: by 2002:a05:6808:2221:b0:3ad:29a4:f54f with SMTP id
 bd33-20020a056808222100b003ad29a4f54fmr6490861oib.4.1696298576935; Mon, 02
 Oct 2023 19:02:56 -0700 (PDT)
Date:   Mon, 02 Oct 2023 19:02:56 -0700
In-Reply-To: <04086fa2-8506-4f6f-8b31-3b539736adc6@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001c82d20606c64a89@google.com>
Subject: Re: [syzbot] [io-uring?] BUG: unable to handle kernel NULL pointer
 dereference in __io_remove_buffers (2)
From:   syzbot <syzbot+2113e61b8848fa7951d8@syzkaller.appspotmail.com>
To:     axboe@kernel.dk
Cc:     asml.silence@gmail.com, axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> #syz test: git://git.kernel.dk/linux.git io_uring-6.6

This crash does not have a reproducer. I cannot test it.

>
> -- 
> Jens Axboe
>
