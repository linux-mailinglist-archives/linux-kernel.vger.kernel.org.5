Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4A17C7C2F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 05:33:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjJMDdY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 23:33:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbjJMDdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 23:33:08 -0400
Received: from correo1.cdmx.gob.mx (mtax.cdmx.gob.mx [189.240.235.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D57CB185;
        Thu, 12 Oct 2023 20:32:51 -0700 (PDT)
Received: from cdmx.gob.mx ([10.250.108.150])
        by correo1.cdmx.gob.mx  with ESMTP id 39D3VrKf019561-39D3VrKh019561
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 12 Oct 2023 21:31:53 -0600
Received: from cdmx.gob.mx (localhost [127.0.0.1])
        by cdmx.gob.mx (Postfix) with ESMTPS id 7E5F5247106;
        Thu, 12 Oct 2023 17:55:21 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
        by cdmx.gob.mx (Postfix) with ESMTP id 5CBA4247104;
        Thu, 12 Oct 2023 17:55:21 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.9.2 cdmx.gob.mx 5CBA4247104
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; d=cdmx.gob.mx; s=DKIM1; c=relaxed/relaxed;
 h=content-type:mime-version:subject:to:from:date:reply-to:message-id;
 bh=8BjWGpd2gMZW01m5ZJfRcA0zuAbJKdXncuFoiLvcpMk=;
 b=WzFEEoWruy6AK2RjYKrXYTPhYZdXCydOo751ksxaNZLOnq1yZpO9bFCRbu0kc0GSIqVfu+Wz7IsV
        fTgJWejk9rVowRqjGnyFDePU47eivmCRc0Uc2iSjXb9xI37PHWcOX3/jDMcCqaZCtiDDTnA2Od16
        7BtbcSH3QpAzBZKmLqihcYz6+YToYHAGTNZg5p6S96DGYlXSy8Gdc881+DGmoE5TR31sfWgApcV7
        /4ci5wZR+/YOrbadj+nSayhBO0/oQR1sI7pVoVEy+422KWaAD3Bb1fusBqyAPNFh3VDABHKe+ltB
        Yz24qAqccCJQqv0dQupUQMhZb3l228GkhcH5nQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cdmx.gob.mx;
        s=2020J4N146MXCTY; t=1697151321;
        bh=zjuytpHvT+A0RPCeVFL53H0fO/7zRptnzzMRCdpRnrY=;
        h=Content-Type:MIME-Version:Subject:To:From:Date:Reply-To:
         Message-Id;
        b=H5GFKIaoex4VzVcB9stAYlfPVeb38fzFTcYRY+/Ohu8wHvrjJaPS+rDB7wZ6AI3vL
         xSLW2ZZbK8CdGT2CvQzEh5yCndCNMCfT6U5t7g4KYQ2IeVvpuFbeUhpyRmNV1AItFp
         tBUTx3lc2K+N310qCH1V3o9mxC93LD7+//d2Tn54=
X-Virus-Scanned: amavisd-new at cdmx.gob.mx
Received: from cdmx.gob.mx ([127.0.0.1])
        by localhost (cdmx.gob.mx [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id eouNAeLrInH5; Thu, 12 Oct 2023 17:55:21 -0500 (CDT)
Received: from [192.168.8.123] (unknown [179.61.245.12])
        by cdmx.gob.mx (Postfix) with ESMTPSA id 894342470C4;
        Thu, 12 Oct 2023 17:54:20 -0500 (CDT)
Content-Type: multipart/alternative; boundary="===============0896497393=="
MIME-Version: 1.0
Subject: $4,800,000.00 dollars for you.
To:     Recipients <ctrinidad@cdmx.gob.mx>
From:   "Mrs. Mavis Wanczyk" <ctrinidad@cdmx.gob.mx>
Date:   Thu, 12 Oct 2023 16:54:21 -0700
Reply-To: maviswanczykdonation34@gmail.com
Message-Id: <20231012225432.894342470C4@cdmx.gob.mx>
X-Spam-Status: Yes, score=6.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,HK_NAME_MR_MRS,LOTS_OF_MONEY,
        MONEY_FREEMAIL_REPTO,SPF_HELO_NONE,SPF_PASS,SUBJ_DOLLARS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5498]
        *  0.1 SUBJ_DOLLARS Subject starts with dollar amount
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [maviswanczykdonation34[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  1.0 HK_NAME_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        *  2.5 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You will not see this in a MIME-aware mail reader.
--===============0896497393==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body

Hello, I have a donation worth $4,800,000.00 dollars for you, I won the Ame=
rica lottery worth $758 million Powerball jackpot and I donated a part of i=
t to charities. you can contact me for further information via (maviswanczy=
kdonation34@gmail.com) for your claim.
--===============0896497393==
Content-Type: text/plain; charset=utf-8
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body

Hello, I have a donation worth $4,800,000.00 dollars for you, I won the A=
merica lottery worth $758 million Powerball jackpot and I donated a part =
of it to charities. you can contact me for further information via (mavis=
wanczykdonation34@gmail.com)) for your claim.

--===============0896497393==--
