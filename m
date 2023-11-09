Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3C1B7E6C74
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 15:33:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234194AbjKIOdC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 09:33:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231659AbjKIOc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 09:32:58 -0500
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AC372D7C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 06:32:56 -0800 (PST)
Received: by mail-vs1-xe41.google.com with SMTP id ada2fe7eead31-45d9d28142fso411271137.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 06:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699540375; x=1700145175; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e3StzxvUkjhfa1ajC4GTcwNAzHX77fyRLBmo5btSYVQ=;
        b=hwSe1i7jFrFB+gQJ6TiipwlXPGZMKgXsxWssoEEhIsP+BTsNvCcSS0ghlwM7Q8dl89
         vJ0jh3ZDityhKZUsERxqsbYG8WRXeT2uVPI2IQvguuUYf2IA3xIjoWA5yyDGlscKo3TL
         pZTxAcJcjElv58/Bo06PjUcG76wY1v3R47JKqybUn/TUL7rkqWOgDXJGkAz8djmIL+wR
         TzIAjwF+amiTFiKr0hI3m2dTQehFF3JoCj+SlTWXdloNdYJr5ZaarUvYIEvLLi6oHXlY
         obg3sLGPIRjATPGtNgUW4vv7Svh4elqKxHh6Ofb/AjDc1mLz9KZfKkENZch0qzT/lnFq
         EYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699540375; x=1700145175;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e3StzxvUkjhfa1ajC4GTcwNAzHX77fyRLBmo5btSYVQ=;
        b=M50lTwliKVWqdwBzh5bSgCpcAhvCbiclcHunPFlF/MVI4Lyz55BQktEZ268XaeC0/u
         WcpET2dLGRpd88PQWDwEOAN4Rd5+RBxXEIoJH+YhfJtYkS7z1lObvE/8VlxJyLhYzZrb
         UB75mBPptz180WoO9RazVIvsrqegCpumqTPcRWQ9gHSEHXcubaFq7/XwNmgEUW1WoWNP
         4VqmdkBMAYjgzgLD4wMwSfXgcVrZOsspM/8gRshXZHBJ8w4oOcCEZ4yHtIEiUW57CDew
         cEiK79+98CB0Wo8thyWVU28U9ERF6vmkjKbOP6uBYoFK224lzLrFPYKWbibgVEl7xIcr
         pkOQ==
X-Gm-Message-State: AOJu0Yyv7RZR4oKQioyYVAXJRvPjrztt3wqSKO7kA/pCF1Vprh0TegU0
        cmmnp28V2yv3+sj71Q/4kvsvnmfPIBN23FHo/Kg=
X-Google-Smtp-Source: AGHT+IHYf4SlojwwLZNOLgEYrV+v0l84bizPNuKmHgKidiAR8hagfAYjqkEokBTyqlIkIi76FBWN9UktY4rSRM3hYlY=
X-Received: by 2002:a67:e107:0:b0:45d:9113:328b with SMTP id
 d7-20020a67e107000000b0045d9113328bmr4754504vsl.24.1699540375055; Thu, 09 Nov
 2023 06:32:55 -0800 (PST)
MIME-Version: 1.0
Sender: edithibrahim2011@gmail.com
Received: by 2002:a59:abca:0:b0:42c:351d:1a92 with HTTP; Thu, 9 Nov 2023
 06:32:54 -0800 (PST)
From:   Aisha Gaddafi <aishagaddaf02@gmail.com>
Date:   Thu, 9 Nov 2023 06:32:54 -0800
X-Google-Sender-Auth: HLZfNdj--ccHU0B8INCzB_AiMDw
Message-ID: <CAP4+oU=Vq1Gh4t6T2-fMNxKht1NRsANaC7CJWPiA_fr-YuEYYA@mail.gmail.com>
Subject: Your Urgent Reply Will Be Appreciated
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Inquiry for Investment.

Dear Friend,

I came across your e-mail contact prior a private search while in need
of your assistance. My name is Aisha Gaddafi a single Mother and a
Widow with three Children. I am the only biological Daughter of late
Libyan President (Late Colonel Muammar Gaddafi).

I have an investment funds worth Twenty Seven Million Five Hundred
Thousand United State Dollar ($27,500,000.00 ) and i need an
investment Manager/Partner and because of the asylum status i will
authorize you the ownership of the funds, however, I am interested in
you for investment project assistance in your country, may be from
there, we can build a business relationship in the near future.

I am willing to negotiate investment/business profit sharing ratio
with you base on the future investment earning profits.

If you are willing to handle this project kindly reply urgent.

Regards
Mrs Aisha Gaddafi
