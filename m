Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B7A7E5EE7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 20:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjKHT6l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 14:58:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbjKHT6j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 14:58:39 -0500
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4EB211D
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 11:58:37 -0800 (PST)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5a7c011e113so1241457b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 11:58:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699473517; x=1700078317; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2NTi/QegNnVCEQq7rooYSxMGN049ehSK5P7btoT2DLE=;
        b=JFK77lWQWecRwPeZPk/mI6omzt/jZvb25LlG5snaoIosYdXOGWk31bZCV7a4hsbso/
         /eS7YEG2wJfkA81X9IJY99v/9IXI+I/FPgWiWesxbfr0lyw2zrcephmlnkmnm/wSwiW7
         tlhDiv2hhX9PzArRdRcpb6uHZHwrc9aGRfu7oJdI9tdWjDaCHMAkk77eNw2zaJpiZxzL
         rZoiqOC5cUaij12e5GagZ9EALGx1IuQ/kC6/sHb2zSQIAaC5Gg88iSKUSDgCvSVO5iwE
         WOoOdiDZex25NCOf0dq1CdmxiTwM7+g9DQjZ3JCuMyU2IjjrHMjEVf0uLONbofrq2UNW
         XMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699473517; x=1700078317;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2NTi/QegNnVCEQq7rooYSxMGN049ehSK5P7btoT2DLE=;
        b=fF4jDFOJaZLCokjUzdcKMn63xOvF4hxjQs1POqcSifw2B7qd5kP4v9ke303r9Zf1fZ
         vG4dYxHA3was7NZiPdKYu/7Wv9DHEcaoKbVLTyomvNMLgHmaUAcFkEIAZoYvbrl2hSDN
         gFd6gElFLxaOxR4XsQAkt5lQV9BMeaNxxovOX9SKX9T/c/dqVt0g79c0VOEK6m/9SgDK
         KhQaXEzlygfJYKjfJOkFevfldlr94dKq4h0d+TA9KC2FpPVYVPuOKEzMtA/BbHkRx1Hz
         aaTIquVhftLu26wYraFklR5n/PWuMkIgYgMo4xYNyDqWAJ8OAq62IKNS+mj7Zm0wfIEm
         fzVQ==
X-Gm-Message-State: AOJu0Yz28rB7d+vCyLFJthLMfQnLNKvtm8rKQyUNyyUZfZUJmjcrxqO7
        sxIQd10UZ0iuZkyVQpetKuNawXPavCGCGcCaJs8=
X-Google-Smtp-Source: AGHT+IG30JXxoOfjPBd2/Ndp25ivewUQ1RLKEN5nGmfMAt9SFdCgO/olZJh6bneoBXjNVnOb+hdsyLPyHz1/FgAI72s=
X-Received: by 2002:a05:690c:ec8:b0:5be:94a6:d919 with SMTP id
 cs8-20020a05690c0ec800b005be94a6d919mr2971362ywb.25.1699473516875; Wed, 08
 Nov 2023 11:58:36 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7010:95cd:b0:385:d591:e270 with HTTP; Wed, 8 Nov 2023
 11:58:36 -0800 (PST)
Reply-To: werinammawussi@gmail.com
From:   Werinam Mawussi <wedemmawussi@gmail.com>
Date:   Wed, 8 Nov 2023 20:58:36 +0100
Message-ID: <CAJHkjaDrdBLZ-_aMFzhpu7veDiErG2sKCNE+3Uw-Tg=5VC-56w@mail.gmail.com>
Subject: Important Notification
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I am bringing this notice to your attention in respect of the death of
a client of mine that has the same surname with you and his fund
valued at $19.9M to be paid to you.contact me at
werinammawussi@gmail.com for more details.

Yours Sincerely,
Werinam Mawussi,
Attorney At Law.
