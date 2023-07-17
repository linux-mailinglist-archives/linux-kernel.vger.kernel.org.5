Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B4F6756DE9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 22:02:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231307AbjGQUCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 16:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229983AbjGQUCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 16:02:16 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B604799
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:02:15 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-315adee6ac8so4818015f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 13:02:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689624134; x=1692216134;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RapVQawOljZ3WkdRWpTvGIEHTklNcouz9V8HkQ49kOY=;
        b=M30353+SYjKT+zKxkEWf6omloTxr+tdZpUljtpeuqiBlmziYRsWq7oYeOjpoeMhmmZ
         uWJiHyu8Scqtkr/W2Y8hg3kkfIk1CuJ3GvefYMK3cnAZbBAmp4C9O3J7RdriTVsnd7SR
         2jFDCaTAyP8cZFerlErfoggYLlnIlsNczDMfg1t+0hplk9+LXsTcgAaww9yud2TXDZ3r
         1MBNGwLtUE7l1SoD3mlf5bSlZTuW1tT8bn01ASyw7EPMVrp0uHHX97RaO6ss00sJ7aU9
         E1I4LhWKBIeXJqoIiXgHJGbylSmEpwJp8EPn8cR8OroaGDahCjNYhUYDZ24dnyrwIQo5
         z9rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689624134; x=1692216134;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RapVQawOljZ3WkdRWpTvGIEHTklNcouz9V8HkQ49kOY=;
        b=kTHmzCJU1D45Nf/3Ip78OzeJddfigehEYTwvXC/HGMi/gDCg6Q38abyzVvCB28VbGE
         WwC7UGAmS3ktqteDUbMZGLbLxFzS5WCZ9re25b7bk/TV2lebHxdSK0yWRkVdzlJ9+juC
         TFBmES0iYVhwltGhHKB1Ky4QkvbFaattAeIBWRAApJ9HZ9ihWYhn6hlyYhaLPKtlvozo
         wuTWTSERqrKC+ZoknU+LEoqDo33FcSdmHPb5P4CvLD+peOktu4zWIAybkq6FqD2Fde8Q
         /FagVstHwBJgHYmwGWyoWhQossXYSSqW0YfbaY7tf3ycEugBf7np5egJEA6/0oF2leRX
         W2iw==
X-Gm-Message-State: ABy/qLahmZDajI4PrWRzE7ljk9o6sAgIfyZbs79mmCuQR/dQVnoVGXoA
        hceJesnnerRkAMVOI7VXUlNEC0o97Wzj+l87CQ==
X-Google-Smtp-Source: APBJJlHSdbUOS2Z7lp0aTCcDntOLmNbqn1kMyROUG85oV7qHNhysiGjZChCht5ZUCDnds7QNjCV1hnzYoidhvH7Du8g=
X-Received: by 2002:a5d:428b:0:b0:314:d31:f7 with SMTP id k11-20020a5d428b000000b003140d3100f7mr10291705wrq.63.1689624134198;
 Mon, 17 Jul 2023 13:02:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:58d8:0:b0:314:3b91:c9dd with HTTP; Mon, 17 Jul 2023
 13:02:13 -0700 (PDT)
Reply-To: Dr.catherine_chan@hotmail.com
From:   catherine chan <grumnevichmicheal@gmail.com>
Date:   Mon, 17 Jul 2023 22:02:13 +0200
Message-ID: <CALcVtqUgZ_R6LLx-tmRr8wnMPjJ4TG++YJzVhs9b0zsiwZ5cGQ@mail.gmail.com>
Subject: Re:Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
Hello! How are you? Please forgive me if my application is not
acceptable by your kind person, I saw your email and I want to talk to
you directly by mail. I would appreciate it if you could send me an
email when you receive it.

Waiting for your prompt response
Greetings,
