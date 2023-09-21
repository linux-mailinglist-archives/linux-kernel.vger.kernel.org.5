Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7187AA017
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 22:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230138AbjIUUc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 16:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbjIUUcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 16:32:00 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B4B7AECD0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:06:21 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id af79cd13be357-76f2843260bso76437685a.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 11:06:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695319580; x=1695924380; darn=vger.kernel.org;
        h=reply-to:date:from:to:subject:content-description
         :content-transfer-encoding:mime-version:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5BfqCn3SI4zJhaJ/BY04ihMcOPLtkiQ9Z9x5owCaadI=;
        b=EhfRTDtpSjpK/GAXN4yArAq7OvBiBXiTFGXUYxANblQfXBaq8FHxNOz/UUFkwxJ5wA
         qTVrYjIlcU8KCK7zRWg44au2+c76eC1vlYHUtXrGsl7lNwXMZ6Pg5j0lhJx+C7m8up5o
         d84EbUPmUzopS9nd6Eb4XvlIkr8QXVaEu2cX/YjjxL14P+FbmPW8khnn0LjZk4rC+WzH
         LfRfPpQuTGgOokpZW8KqBWN3wkjP+f3hAbfABptVRt2oVly7h7GAn9cb8ZRVlfZiSi/O
         3SHIHfMR3ro6Yf83JtWWmUzZ2ZPy7aZHMxOmoSAQuUVNy/gLrn3LJbsbt6du9XZKnAIi
         TYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695319580; x=1695924380;
        h=reply-to:date:from:to:subject:content-description
         :content-transfer-encoding:mime-version:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5BfqCn3SI4zJhaJ/BY04ihMcOPLtkiQ9Z9x5owCaadI=;
        b=YZe/lrzd8P8c0qHNcOs8VKPqDQ6zPD1DJ1B8BGm8toJhyxoU88krrXCkmTqo5qUWXt
         WrzRyknL4YW4aWMNezRlXxj9a1J2PDQSSa9DMJ6Pfkeh+n7Lu8O08iWCSBwP+4RaWcgq
         VZ0bdf7zneoe19z/WafMac8zE24ZmgCL/vhBQmHo6A8HzaUaLMX3JhMQmklrk2JeY102
         dw/Nr7u3heunmXcxu0yfuE9dFx63isrqLm3wdkcTZ0B3O1q+ZSPjMLkA9NJabOcYZRAE
         6KRSAClakDjyDBqsh0xyf7shC/Dj8R7zUx5M+8PEDs0L44MLEvM/qVjNuBuH+Wmv7u0g
         Nu2g==
X-Gm-Message-State: AOJu0Yy1sxLsUR+w2axFz6POj6mwHpkFOpRHfhwZhzwQZr7GFJbGXETg
        ksCqH+VvgjbPoXeoBgUZsuKjB8nuscB62fAVvDk=
X-Google-Smtp-Source: AGHT+IHd3iGA+S6h7idqLQFgIhpzyOe+6zpzJzX/HU8N51aG9BgMtIAL+x/X63hH5W9MqLbXvCYh9w==
X-Received: by 2002:a17:90b:8d6:b0:274:8330:c7da with SMTP id ds22-20020a17090b08d600b002748330c7damr4668286pjb.28.1695270206272;
        Wed, 20 Sep 2023 21:23:26 -0700 (PDT)
Received: from [192.168.8.100] ([203.144.88.35])
        by smtp.googlemail.com with ESMTPSA id t19-20020a17090b019300b00274922d4b38sm350263pjs.27.2023.09.20.21.23.20
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 20 Sep 2023 21:23:25 -0700 (PDT)
Message-ID: <650bc53d.170a0220.49bf.1d24@mx.google.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Financing Project Proposal
To:     Recipients <hrperycapdonotreply@gmail.com>
From:   "Ronald Scott" <hrperycapdonotreply@gmail.com>
Date:   Thu, 21 Sep 2023 11:23:13 +0700
Reply-To: ronscoltt@gmail.com
X-Spam-Status: No, score=3.6 required=5.0 tests=BAYES_50,DEAR_SOMETHING,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Sir,

Greetings.

My name is Ronald Scott, I'm a broker and Financial Facilitator.We are an i=
nternational financial giant with an A+ credit rating, A series of conclude=
d businesses and strong partnerships achieved by years of continuous dilige=
nce, trust and uninterrupted attention to our clients.

Because of the prevailing economic situation affecting companies world over=
,our investors are seeking new business opportunities and projects for poss=
ible funding and capital financing. We are open to further discussions.

It will be nice to meet your acquaintance. We seek to know the possibility =
of going into partnership discussion with your company within your present =
scope of business. We would be happy to do so in whatever medium you find m=
uch more appropriate for this engagement.

If you wish to act as an agent or you have anyone who might be interested, =
we are willing to compensate you  with a reasonable commission.

Once I hear from you, we will set up formal channels of communications and =
possible meeting.

I look forward to working with you.

Regards,
Ronald Scott.
