Return-Path: <linux-kernel+bounces-127891-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6453895267
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 610881F2167E
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:05:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 157E86E602;
	Tue,  2 Apr 2024 12:04:52 +0000 (UTC)
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E61126996C;
	Tue,  2 Apr 2024 12:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712059491; cv=none; b=hHhdp4TVShFwO1W3YQt/MzGEmLX/s+2ADUXCB8ONX8QuB0mpAjWUqdr2LUsvFEwp049qRDGY9eXraTrktBzFI8x0+F3SQium9px05oEyW7BKzXaOZNeCaClTan8dBMcWzPeL/v56baQ5X9fMbNjP3ubHp1NrCN0sxlriiLRtfuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712059491; c=relaxed/simple;
	bh=I64Eqs7ZEABJML3rrVIwNYOOdTZWWqMoWl+DY44H0dU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lVvWJOzA8YMoTTx8m4O/ClfO8Q6RFi4a/xsSqxF7IFzXuUvSa68gYtITjEXpIpJlo8hK9Ye76xZPZun2V+qdnhur8gnmChGslqmhwLuYGxo8ZVNZBE/p22GdGXYw0xWr2bMSG4erZDPVkOq4PPimWGy43N1ECCgRQswy6aM0cEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.109.80])
	by gateway (Coremail) with SMTP id _____8AxDOtd9AtmGVEiAA--.3617S3;
	Tue, 02 Apr 2024 20:04:45 +0800 (CST)
Received: from [192.168.100.8] (unknown [112.20.109.80])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8DxdRFa9AtmvtBxAA--.12917S3;
	Tue, 02 Apr 2024 20:04:43 +0800 (CST)
Message-ID: <d5baa094-94e7-4898-a559-c2f89787e8e1@loongson.cn>
Date: Tue, 2 Apr 2024 20:04:42 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs/zh: Fix Cc, Co-developed-by, and Signed-off-by tags
To: Alex Shi <seakeel@gmail.com>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Alex Shi <alexs@kernel.org>,
 Jonathan Corbet <corbet@lwn.net>, Hu Haowen <2023002089@link.tyut.edu.cn>
Cc: linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <22892a8ab5c17d7121ef5b85f7d18d8b1f41e434.1711715655.git.geert+renesas@glider.be>
 <339b5603-c09a-41de-af75-cf0f196a6310@gmail.com>
Content-Language: en-US
From: Yanteng Si <siyanteng@loongson.cn>
In-Reply-To: <339b5603-c09a-41de-af75-cf0f196a6310@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8DxdRFa9AtmvtBxAA--.12917S3
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW3Wr45Cry8ZF47ZFyxuF18tFc_yoW7Kr4fpF
	nI9ry3JF1xJF1UC3yxKFy8XryUKa9rAFsxKFy0yw1Sqr1vvrWSyFn0yr9a9F9xW34fKFyU
	CFs3AFy8Cr4UZrgCm3ZEXasCq-sJn29KB7ZKAUJUUUU7529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUU9jb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVWxJr0_GcWln4kS14v26r1Y6r17M2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12
	xvs2x26I8E6xACxx1l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r12
	6r1DMcIj6I8E87Iv67AKxVWxJVW8Jr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI4
	8JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMxCIbckI1I0E14v26r1Y
	6r17MI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7
	AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE
	2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcV
	C2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2Kfnx
	nUUI43ZEXa7IU8rsqJUUUUU==


在 2024/4/1 09:40, Alex Shi 写道:
>
> On 3/29/24 8:35 PM, Geert Uytterhoeven wrote:
>> The updates from commit ae67ee6c5e1d5b6a ("docs: fix Co-Developed-by
>> docs") in v5.0 were never applied to the Chinese translations.
>> In addition:
>>    - "Cc" used wrong case,
>>    - "Co-developed-by" lacked a dash,
>>    - "Signed-off-by" was misspelled.
>>
>> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> LGTM
> Reviewed-by: Alex Shi <alexs@kernel.org>
Reviewed-by: Yanteng Si  <siyanteng@loongson.cn>
>
>
>> ---
>>   .../translations/zh_CN/process/submitting-patches.rst     | 8 ++++----
>>   .../translations/zh_TW/process/submitting-patches.rst     | 8 ++++----
>>   2 files changed, 8 insertions(+), 8 deletions(-)
>>
>> diff --git a/Documentation/translations/zh_CN/process/submitting-patches.rst b/Documentation/translations/zh_CN/process/submitting-patches.rst
>> index f8978f02057c164c..7864107e60a85c58 100644
>> --- a/Documentation/translations/zh_CN/process/submitting-patches.rst
>> +++ b/Documentation/translations/zh_CN/process/submitting-patches.rst
>> @@ -333,10 +333,10 @@ Linus 和其他的内核开发者需要阅读和评论你提交的改动。对
>>   未参与其开发。签署链应当反映补丁传播到维护者并最终传播到Linus所经过的 **真实**
>>   路径，首个签署指明单个作者的主要作者身份。
>>   
>> -何时使用Acked-by:，CC:，和Co-Developed by:
>> +何时使用Acked-by:，Cc:，和Co-developed-by:
>>   ------------------------------------------
>>   
>> -Singed-off-by: 标签表示签名者参与了补丁的开发，或者他/她在补丁的传递路径中。
>> +Signed-off-by: 标签表示签名者参与了补丁的开发，或者他/她在补丁的传递路径中。
>>   
>>   如果一个人没有直接参与补丁的准备或处理，但希望表示并记录他们对补丁的批准/赞成，
>>   那么他们可以要求在补丁的变更日志中添加一个Acked-by:。
>> @@ -358,8 +358,8 @@ Acked-by：不一定表示对整个补丁的确认。例如，如果一个补丁
>>   Co-developed-by: 声明补丁是由多个开发人员共同创建的；当几个人在一个补丁上工
>>   作时，它用于给出共同作者（除了From:所给出的作者之外）。因为Co-developed-by:
>>   表示作者身份，所以每个Co-developed-by:必须紧跟在相关合作作者的签署之后。标准
>> -签署程序要求Singed-off-by:标签的顺序应尽可能反映补丁的时间历史，无论作者是通
>> -过From:还是Co-developed-by:表明。值得注意的是，最后一个Singed-off-by:必须是
>> +签署程序要求Signed-off-by:标签的顺序应尽可能反映补丁的时间历史，无论作者是通
>> +过From:还是Co-developed-by:表明。值得注意的是，最后一个Signed-off-by:必须是
>>   提交补丁的开发人员。
>>   
>>   注意，如果From:作者也是电子邮件标题的From:行中列出的人，则From:标签是可选的。
>> diff --git a/Documentation/translations/zh_TW/process/submitting-patches.rst b/Documentation/translations/zh_TW/process/submitting-patches.rst
>> index 99fa0f2fe6f414e1..f12f2f193f855cfb 100644
>> --- a/Documentation/translations/zh_TW/process/submitting-patches.rst
>> +++ b/Documentation/translations/zh_TW/process/submitting-patches.rst
>> @@ -334,10 +334,10 @@ Linus 和其他的內核開發者需要閱讀和評論你提交的改動。對
>>   未參與其開發。簽署鏈應當反映補丁傳播到維護者並最終傳播到Linus所經過的 **真實**
>>   路徑，首個簽署指明單個作者的主要作者身份。
>>   
>> -何時使用Acked-by:，CC:，和Co-Developed by:
>> +何時使用Acked-by:，Cc:，和Co-developed-by:
>>   ------------------------------------------
>>   
>> -Singed-off-by: 標籤表示簽名者參與了補丁的開發，或者他/她在補丁的傳遞路徑中。
>> +Signed-off-by: 標籤表示簽名者參與了補丁的開發，或者他/她在補丁的傳遞路徑中。
>>   
>>   如果一個人沒有直接參與補丁的準備或處理，但希望表示並記錄他們對補丁的批准/贊成，
>>   那麼他們可以要求在補丁的變更日誌中添加一個Acked-by:。
>> @@ -359,8 +359,8 @@ Acked-by：不一定表示對整個補丁的確認。例如，如果一個補丁
>>   Co-developed-by: 聲明補丁是由多個開發人員共同創建的；當幾個人在一個補丁上工
>>   作時，它用於給出共同作者（除了From:所給出的作者之外）。因爲Co-developed-by:
>>   表示作者身份，所以每個Co-developed-by:必須緊跟在相關合作作者的簽署之後。標準
>> -簽署程序要求Singed-off-by:標籤的順序應儘可能反映補丁的時間歷史，無論作者是通
>> -過From:還是Co-developed-by:表明。值得注意的是，最後一個Singed-off-by:必須是
>> +簽署程序要求Signed-off-by:標籤的順序應儘可能反映補丁的時間歷史，無論作者是通
>> +過From:還是Co-developed-by:表明。值得注意的是，最後一個Signed-off-by:必須是
>>   提交補丁的開發人員。
>>   
>>   注意，如果From:作者也是電子郵件標題的From:行中列出的人，則From:標籤是可選的。


