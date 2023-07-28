Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1F3B76651D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 09:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234070AbjG1HS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 03:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233813AbjG1HSr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 03:18:47 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 870651BE8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:18:34 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-52256241b76so2267992a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 00:18:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=student.uny.ac.id; s=google; t=1690528713; x=1691133513;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VSwqUS7goTjfLEpDEwtCq/J/xnHBh7PzGkQ23ui471g=;
        b=GO2DBQ9Dnj+JBNshifj/OuCn8IWKaUYsF4Lj+Xf4AzI7UmBt0esVN+dIaoyWtPxt9Y
         QZmxExd85X5WrOeE7NGYcDBUCRSSTiPPu0IkAk2zEh90H6IYghc6RGcT9l+PS5UZu6e9
         GEQ2U6uVrhnX0imV/IHVWbDupoXAsUjLWbJYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690528713; x=1691133513;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=VSwqUS7goTjfLEpDEwtCq/J/xnHBh7PzGkQ23ui471g=;
        b=TBAWBoSNqPIMh3IeDsAYjblaF1j/Yl/o0ERY5i2YQiAjnydu+pZFaghWAkXYf8opTw
         jyI6+UDv9mGWzr8Zc1nwhsuV1lh8TmEvedXpEwOjW+3X71LTLpil4Ua1TQSCghtjleNo
         WWkYJB6h/5WlxqzGDXvjSWJj+lbRB9usRnjP0WKi+DOxjPw0eagez67Eg8PT6Jl+/eC5
         +KJXzjZBK4KDXlWBC+2+9eJtnfEudCixcqHqMNOad07nlO+wipCZAiJlKtr6xsXk0uiC
         9OevdCOovSZcAd8Z6C4Hc1YRIG7FDSr1y9A0kiHJroEgDMmaVSo6K7/fOGXh2jaXVAjm
         c23w==
X-Gm-Message-State: ABy/qLZu3CEP9s9cCMBRCnbMj6fh4FOj7+D7r1nvhKR8rU2yF4q9Jrwm
        ufukMGixv8TcP4g8GQNxixsu0W7UgD9n7jPSjb2mwYq41Eap24Wj+mg6T4iyR3e0uSCNc4SnKXA
        ed8+868cIW+PhJzBYz/d2cY8FOD+G5+NyIQ==
X-Google-Smtp-Source: APBJJlGbuJ4a/jCMA+N+9HmiCuad2bhILPbFtUCJjdADd5tXbEx4cM9vTmKXN+xYOkZiWgdorHGyL4Y+MKxpE8ngl+Q=
X-Received: by 2002:a17:906:3096:b0:99b:4aa3:6480 with SMTP id
 22-20020a170906309600b0099b4aa36480mr40340ejv.40.1690528712887; Fri, 28 Jul
 2023 00:18:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:906:9b90:b0:973:9c54:5722 with HTTP; Fri, 28 Jul 2023
 00:18:32 -0700 (PDT)
Reply-To: suniew63@gmail.com
From:   15803244004 SOLIKHAH <solikhah.2015@student.uny.ac.id>
Date:   Fri, 28 Jul 2023 07:18:32 +0000
Message-ID: <CALibd7A3fWorazxHG8rPmVsupN1w6Vbu9Qgp2JtybBH42xTi+g@mail.gmail.com>
Subject: HI
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=3.3 required=5.0 tests=BAYES_50,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FORGED_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

5oiR57uZ5oKo55qE6YKu566x5Y+R5LqG5LiA5bCB5L+h77yM5L2G5rKh5pyJ5pS25Yiw5oKo55qE
5Zue5aSN44CC5oKo5pS25Yiw5oiR5LmL5YmN55qE6YKu5Lu25LqG5ZCX77yf6K+356iN5ZCO5YaN
6ZiF6K+75oKo55qE6YKu5Lu2DQoNCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQoN
Ckkgc2VudCBhIGxldHRlciB0byB5b3VyIG1haWwgYnV0IGdvdCBubyByZXBseSBmcm9tIHlvdS5E
aWQgeW91IHJlY2VpdmUNCm15IHByZXZpb3VzIG1haWwgcGxlYXNlIGkgd2FpdCB0byByZWFkIHlv
dXIgbWFpbCBzb29uDQoKLS0gCgoKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS1VbnR1ayBtZW5kdWt1bmcg4oCcR2VyYWthbiBVTlkgCkhpamF14oCdLCBkaXNhcmFu
a2FuIHRpZGFrIG1lbmNldGFrIGVtYWlsIGluaSBkYW4gbGFtcGlyYW5ueWEuCihUbyBzdXBwb3J0
IAp0aGUg4oCcR3JlZW4gVU5ZIG1vdmVtZW504oCdLCBpdCBpcyByZWNvbW1lbmRlZCBub3QgdG8g
cHJpbnQgdGhlIGNvbnRlbnRzIG9mIAp0aGlzIGVtYWlsIGFuZCBpdHMgYXR0YWNobWVudHMpClVu
aXZlcnNpdGFzIE5lZ2VyaSBZb2d5YWthcnRhCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIAp3
d3cudW55LmFjLmlkIDxodHRwOi8vd3d3LnVueS5hYy5pZD4KLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQoK
