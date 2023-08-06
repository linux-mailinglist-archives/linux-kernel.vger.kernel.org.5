Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 726CA771725
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 00:03:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbjHFWAv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 18:00:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHFWAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 18:00:50 -0400
Received: from mail.vast.vn (mail.vast.vn [210.86.230.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C48A4171E
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 15:00:45 -0700 (PDT)
Received: from mail.vast.vn ([10.18.2.60])
        by mailgw.vast.vn  with ESMTP id 376Lwktw000950-376Lwku0000950
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 7 Aug 2023 04:58:47 +0700
Received: from localhost (localhost [127.0.0.1])
        by mail.vast.vn (Postfix) with ESMTP id 36157C1E20DE4;
        Mon,  7 Aug 2023 04:55:40 +0700 (+07)
X-Virus-Scanned: amavis at mail.vast.vn
Received: from mail.vast.vn ([127.0.0.1])
 by localhost (mail.vast.vn [127.0.0.1]) (amavis, port 10026) with ESMTP
 id J9MGh6sf4v6y; Mon,  7 Aug 2023 04:55:40 +0700 (+07)
Received: from mail.vast.vn (mail.vast.vn [10.18.2.60])
        by mail.vast.vn (Postfix) with ESMTP id DE57CC1E20DC2;
        Mon,  7 Aug 2023 04:55:37 +0700 (+07)
Date:   Mon, 7 Aug 2023 04:55:37 +0700 (ICT)
From:   Michele Brad <nguyenmanhtuan@iams.vast.vn>
Reply-To: michelebrad11@gmail.com
Message-ID: <1131616559.15064.1691358937715.JavaMail.zimbra@iams.vast.vn>
Subject: Re
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.2.60]
X-Mailer: Zimbra 8.8.15_GA_4562 (zclient/8.8.15_GA_4562)
Thread-Index: 3bPnu0k7BV4cV6Gzb80gjkE9C3bGaw==
Thread-Topic: Re
X-FE-Policy-ID: 2:1:0:SYSTEM
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=iams.vast.vn; s=iams.vast.vn; c=relaxed/relaxed;
 h=date:from:reply-to:message-id:subject:mime-version:content-type;
 bh=HnIXGvQPI+R5w3GNi3bzfmwbG9UL02IdFHfB9eZ7jCE=;
 b=v121KhAV6bnS3veYxLKTShFG94fOujSUfM449SetEWtRfwmrJIJP+nbuXVU9Ocdx6qTRZoNrp/v7
        PZfdylpkBLYfgtoiClzKlMbcHYpyNkCHa7s7ry7v6bdGgcUU8mQzTSIE/m+DffO+wei6Q31mfUUC
        Zqk0ZdTz/a57AKKBVIUYLeeIUY1OJE+1TzZhmHrs5Khr0Ui6eYpHHjQi3sa9ysJv0ldnNj0lElZn
        H8BhoFlkH4M24hI4jc3pHSmFEJCEMnlwF1rnXunNyFu9Ed2yzFc3vEIcZhhObtY8oEqvaO5qApSB
        rHe/RvL4D8AS/IJitzxoa7Dcb80vGZ+6jkUxtg==
X-Spam-Status: Yes, score=5.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,MISSING_HEADERS,RCVD_IN_DNSWL_BLOCKED,
        REPLYTO_WITHOUT_TO_CC,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.0 RCVD_IN_DNSWL_BLOCKED RBL: ADMINISTRATOR NOTICE: The query to
        *      DNSWL was blocked.  See
        *      http://wiki.apache.org/spamassassin/DnsBlocklists#dnsbl-block
        *      for more information.
        *      [210.86.230.123 listed in list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_HELO_PASS SPF: HELO matches SPF record
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [michelebrad11[at]gmail.com]
        *  1.0 MISSING_HEADERS Missing To: header
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  1.6 REPLYTO_WITHOUT_TO_CC No description available.
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do you get my previous mail
