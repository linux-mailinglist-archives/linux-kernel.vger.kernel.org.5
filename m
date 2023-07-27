Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56CC9765C02
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 21:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbjG0TVC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 15:21:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbjG0TU7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 15:20:59 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D4EF3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 12:20:58 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742eso14877195e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 12:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690485657; x=1691090457;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RapVQawOljZ3WkdRWpTvGIEHTklNcouz9V8HkQ49kOY=;
        b=jtXlNnlb8VrQa89C/xWYSkrHoxGbR1vtZ2IB7NhpmIHiaT17nvhW9sHTJlKYMnwnW0
         6mlwTwL7+5ddS9lwNqPYJjIwBnB7Dao7Y33eGG5GiZi33TMnVhiEK0dV2+0POYTC2TGz
         8erp18eltcN9xzQR1ZDYEoTLss4UgerRAflplGIXlpt31QRaI/gV+jLEiZz4Err90vnn
         oKjrUkRLSEHZS6WNAbF+yvU8T+L50P1SQaMR8e5/64v9JJVSv1VVN6xtNmTMJEugT7cz
         d3nZG6KvQbAVpGbclWUUIJFp54xUiWbBaddrmzN2lowAS8uo6g2GoxDxyak+GwN5V/VL
         q5+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690485657; x=1691090457;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RapVQawOljZ3WkdRWpTvGIEHTklNcouz9V8HkQ49kOY=;
        b=Ri3x5FyflsPpAaPyzP/ze6uK/e7KQhF3jG4kC3Wogv9Tubt5osWNqkzmowB4Jxj2JD
         HEmpv1o9i6xZGwXmhf8sj+Y9/LI3krlKAHCiTRBCB5O97QYEGgz++Xsj7/yWD6Kk2NK5
         Sf5nQ8oZeTVlTzr8Lj+6oiZFrrkAK1KoJsiwyDo126dcL+V9tJ5eBAxXfoXIjgjpoEHD
         9cINuoRzl3S34EAcUITzJbHhjkNVx7q3GKkhXtKC8yqny6qgOXhgzpEhM1m3kdeNzTk6
         ez+jaBMl/qHSL212S3xUVMhsi7N5U7I//IQfkroyKj5/cXQd0TK+Ry1dKs9CCuRlb9MP
         goUw==
X-Gm-Message-State: ABy/qLa+JSquCc1ZfMBJErk/D4hH8b8RQddosBE2L/4Tq9fwLgQRKUdm
        Z8+Dx9Zse/EYODAC+jtz/uXBquF2/cPPUdIl2g==
X-Google-Smtp-Source: APBJJlG49iGexUerhYXyzh7ruNhwkeS2moI7eydj7kl7DTBNhjtlrqQWucxOWwUPvi2SVPfdSmU1LXIq0zJCFmnHcSY=
X-Received: by 2002:a5d:6352:0:b0:315:9362:3c70 with SMTP id
 b18-20020a5d6352000000b0031593623c70mr51538wrw.60.1690485656901; Thu, 27 Jul
 2023 12:20:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:e3c1:0:b0:314:3b91:c9dd with HTTP; Thu, 27 Jul 2023
 12:20:56 -0700 (PDT)
Reply-To: Dr.catherine_chan@hotmail.com
From:   catherine chan <grumnevichmicheal@gmail.com>
Date:   Thu, 27 Jul 2023 21:20:56 +0200
Message-ID: <CALcVtqWheFB=+KtUGPHabetaMemmtJB7VhzDqsu67EqOUim-kw@mail.gmail.com>
Subject: Re:Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
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
