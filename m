Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 133007A5611
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 01:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjIRXHk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 19:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjIRXHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 19:07:38 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 716E397
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 16:07:33 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-d8195078f69so4348199276.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 16:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695078452; x=1695683252; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q+TPbrASOBnfYJSFticEUTV5irnTXQkF43cHscnKaUc=;
        b=J2+fzSvwaB8WKE7Bx4l/jyGzc8Niie8aqJvOk/c6hBjpHOoD+xN7nlTzI/iUYkF2fC
         tBnZw6ghImb58HdJhABvj9Jb1a+8oqpeZ6LK4ZJqcJmRBncFtfTZKBUgVj1PZmlU2kxR
         nza7qqPPVfk7KUWCOQW/HT0bbsSRO0Z1DhR8CoElSPpwMjb6SrU1xi0irmOsKG69KXlU
         EuubnPMGwBbaJixhRRYZTgP+sU8726jGaa0g+LZGXKNzYf/S1SlmjeYQS6TwWSHtLG2T
         07PU45awM7Y9ruwOGAGPYUaItlyyi7LP55VzTb05IYqQZhyJzDkKqjB8vZlyAX/+SyiG
         hnEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695078452; x=1695683252;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q+TPbrASOBnfYJSFticEUTV5irnTXQkF43cHscnKaUc=;
        b=FYUfmRWs/DKey+CzeYbqdDii+ALYU082u8e0C38muo+vqpsc5Ksi0ZDpq5EfIrjUjV
         PL27qNK/kUrynYr2hkoghx+WlsJBy7+/mrlXtjNxd+Em7WqSmry3hsMyv4Vu95CV05Qj
         x3tCYSllTfujGlgAhf3g9zw1XGYeyGSniGZW/Wu/3FiOWMF2ItPnqSv4zQ/PRVxz5PDk
         aVZQ4UJCHYgDljZBmDI206+NIc8vB4d10fIh2h9Nn1W6iC9k5Xkfi8LjmRr7Sk+ajfa9
         C58S9551hjpNCnDgBwt54M6viaQp6kiXiEH4j4brxsPP7NbJ8W7900jZ6jxk0Fy9Gjy5
         fi6w==
X-Gm-Message-State: AOJu0YxLWF2XHrukseM6xLGCEfMIcpthrm7HQI26g0IDZIs4NXcJWhsb
        uF5MelhcgkByvcpJX/jVQ+ekQMmoQTjiZ8eTjqs=
X-Google-Smtp-Source: AGHT+IH/bTdQ6/NUX7rg/gBIhfjuyfZwf57LY70/eQplbBGDe3k0/w/h+gO5w0sGk1UM/0vQ3UJEMXcBTrv2bgSNmg4=
X-Received: by 2002:a25:daca:0:b0:d81:aa61:c465 with SMTP id
 n193-20020a25daca000000b00d81aa61c465mr10642060ybf.32.1695078452492; Mon, 18
 Sep 2023 16:07:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7108:78cf:b0:2ea:17f1:81e4 with HTTP; Mon, 18 Sep 2023
 16:07:32 -0700 (PDT)
Reply-To: mohamadsana@aol.com
From:   Sana Mahomad <msnfo387@gmail.com>
Date:   Mon, 18 Sep 2023 16:07:32 -0700
Message-ID: <CAMR1riDiRo4d86cyM4oZcPKbJBBykui54_0J-85hjSdjqbzQKQ@mail.gmail.com>
Subject: Dear Intented Recepient
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=7.9 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNDISC_FREEM,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: *  1.5 BAYES_60 BODY: Bayes spam probability is 60 to 80%
        *      [score: 0.6777]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:b2b listed in]
        [list.dnswl.org]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [msnfo387[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [msnfo387[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  2.6 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  2.8 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings!

I was touched to send this message to you after I have carefully gone
through your profile that speaks good of you.

I am Mr.Sana Mohamad, a banker from Burkina Faso. I am writing to let
you know my heart desire to partner and execute a business with you.

For more information, your prompt response and acceptance would be
most gratefully appreciated.

Yours respectfully,
Mr.Sana Mohamad
